//
//  ViewController.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/8/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "ViewController.h"
#import "GPIOTableViewController.h"
#import "AdcTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.personality = [[PersonalityData alloc] init];
    self.gpioData = [[GpioData alloc] init];
    self.adcData = [[AdcData alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CBCentralManagerDelegate

// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if ([central state] == CBCentralManagerStatePoweredOff) {
//        NSLog(@"CoreBluetooth BLE hardware is powered off");
        
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
//        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");

    }
}

#pragma mark - CBPeripheralDelegate

// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    double numberOfServices = 0;
    for (CBService *service in peripheral.services) {
//        NSLog(@"Discovered service: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
        numberOfServices++;
    }
    
//    NSLog(@"Number of services = %.1f", numberOfServices);
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic * characteristic in [service characteristics])
    {
        // Discover all descriptors for each characteristic.
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        [peripheral setNotifyValue:true forCharacteristic:characteristic];
    }
    [self sendValue:@"PERS"];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ScanForDevices"]) {
        
        ScanDevicesTableViewController *scanDevicesTableViewController = (ScanDevicesTableViewController *)segue.destinationViewController;
        
        scanDevicesTableViewController.deviceSelectionDelegate = self;
        scanDevicesTableViewController.peripheralManagerDelegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"ShowGPIOControl"]) {
        
        GPIOTableViewController *gpioTableViewController = (GPIOTableViewController *)segue.destinationViewController;
        
        self.gpioInputUpdatedelegate = gpioTableViewController;
        gpioTableViewController.gpioData = self.gpioData;
    }
    
    if ([segue.identifier isEqualToString:@"ShowAdcControl"]) {
        
        AdcTableViewController *adcTableViewController = (AdcTableViewController *)segue.destinationViewController;
        
        self.adcInputUpdatedelegate = adcTableViewController;
        adcTableViewController.adcData = self.adcData;
    }
}

/***** RECEIVE DATA *******/
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString * str = [[NSString alloc] initWithData:[characteristic value] encoding:NSUTF8StringEncoding];
    
    self.dataReceived = [[IncomingData alloc] initWithString:str];
    
    [self processData:self.dataReceived];

    self.DataReceivedTextField.text = str;
}

/***** SEND DATA *******/
- (void)sendValue:(NSString *) str
{
    NSString *strData = [NSString stringWithFormat:@"%@:", str];
    for (CBService * service in [self.selectedPeripheral services])
    {
        for (CBCharacteristic * characteristic in [service characteristics])
        {
            [self.selectedPeripheral writeValue:[strData dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
        }
    }
}

#pragma mark Scan Devices View Controller Delegate Method

- (void)bluetoothDeviceSelected:(CBPeripheral *)peripheral withCentralManager:(CBCentralManager *)central {
    
     //ask the peripheral to discover the services associated with the peripheral device
    self.centralManager = central;
    self.centralManager.delegate = self;
    
    self.selectedPeripheral = peripheral;
    [self.selectedPeripheral setDelegate:self];
    [self.selectedPeripheral discoverServices:nil];
    
//    NSLog(@"A Device was selected");
}

#pragma mark Callbacks

-(IBAction)SendButton:(id)sender {
    [self sendValue:self.SendTextField.text];
    self.SendTextField.text = @"";
}

-(void)dismissKeyboard {
    [self.SendTextField resignFirstResponder];
    [self.DataReceivedTextField resignFirstResponder];
}

-(void)processData:(IncomingData *)data {
    
    switch ([data getCommand]) {

        case Personality_DataType:
            
            if ([[data getSubCommand] isEqualToString:@"INP"]) {

                for (int i = 0; i < [[data getGpioInputPersonalityData].availablePinNumbers count]; i++) {
                    
                    NSNumber *availablePin = [[data getGpioInputPersonalityData].availablePinNumbers objectAtIndex:i];
                    
                    BOOL pinIsOnTheList = [self.personality.gpioInputPersonalityData.availablePinNumbers containsObject:availablePin];
                    
                    if (!pinIsOnTheList && ![availablePin isEqual:@""]) {
                        
                        [self.personality.gpioInputPersonalityData.availablePinNumbers addObject:availablePin];
                    }
                }
                
                [self.gpioData initInputsWithData:self.personality.gpioInputPersonalityData.availablePinNumbers];
            }
            
            else if([[data getSubCommand] isEqualToString:@"OUT"])
            {
                
                for (int i = 0; i < [[data getGpioOutputPersonalityData].availablePinNumbers count]; i++) {
                    NSNumber *availablePin = [[data getGpioOutputPersonalityData].availablePinNumbers objectAtIndex:i];
                    BOOL pinIsOnTheList = [self.personality.gpioOutputPersonalityData.availablePinNumbers containsObject:availablePin];

                    if (!pinIsOnTheList && ![availablePin isEqual:@""]) {
                        
                        [self.personality.gpioOutputPersonalityData.availablePinNumbers addObject:availablePin];
                    }
                }
                
                [self.gpioData initOutputsWithData:self.personality.gpioOutputPersonalityData.availablePinNumbers];
            }
            
            else if ([[data getSubCommand] isEqualToString:@"ADC"]) {
                
                for (int i = 0; i < [[data getAdcPersonalityData].availablePinNumbers count]; i++) {
                    
                    NSNumber *availablePin = [[data getAdcPersonalityData].availablePinNumbers objectAtIndex:i];
                    
                    BOOL pinIsOnTheList = [self.personality.adcPersonalityData.availablePinNumbers containsObject:availablePin];
                    
                    if (!pinIsOnTheList && ![availablePin isEqual:@""]) {
                        
                        [self.personality.adcPersonalityData.availablePinNumbers addObject:availablePin];
                    }
                }

                [self.adcData initAdcInputsWithData:self.personality.adcPersonalityData.availablePinNumbers];
            }
            break;
            
        case Adc_DataType:
            [self.adcInputUpdatedelegate updateAdcInput:data.payload[0] withValue:data.payload[1]];
            
            break;
            
        case Pwm_DataType:
            NSLog(@"Received PWM data");
            break;
            
        case Gpio_DataType:
            
            if ([[data getSubCommand] isEqualToString:@"INPUT"])
            {
                [self.gpioInputUpdatedelegate updateDigitalInput:data.payload[1] withValue:data.payload[2]];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark Delegate Methods

- (void) updateDigitalOutput:(NSInteger)outputNumber withValue:(NSInteger)state {
    
    NSString *message = [NSString stringWithFormat:@"OUT:%ld:%ld", (long)outputNumber, (long)state];
    
    [self sendValue:message];
}

@end
