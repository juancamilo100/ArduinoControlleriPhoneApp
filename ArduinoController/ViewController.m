//
//  ViewController.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/8/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
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
        NSLog(@"CoreBluetooth BLE hardware is powered off");
        
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");

    }
}

#pragma mark - CBPeripheralDelegate

// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    double numberOfServices = 0;
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
        numberOfServices++;
    }
    
    NSLog(@"Number of services = %.1f", numberOfServices);
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
    NSLog(@"Reached characteristics");
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ScanForDevices"]) {
        
        ScanDevicesTableViewController *scanDevicesTableViewController = (ScanDevicesTableViewController *)segue.destinationViewController;
        
        scanDevicesTableViewController.deviceSelectionDelegate = self;
        scanDevicesTableViewController.peripheralManagerDelegate = self;
    }
}

/***** RECEIVE DATA *******/
// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString * str = [[NSString alloc] initWithData:[characteristic value] encoding:NSUTF8StringEncoding];
    
    self.dataReceived = [[IncomingData alloc] initWithString:str];
    
    [self processData:[self.dataReceived getDataType]];
    
    NSLog(@"Received data size = %d", (int)[str length]);
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
    
    NSLog(@"A Device was selected");
}

#pragma mark Callbacks

-(IBAction)SendButton:(id)sender {
    NSLog(@"%@", self.SendTextField.text);
    [self sendValue:self.SendTextField.text];
    self.SendTextField.text = @"";
}

-(void)dismissKeyboard {
    [self.SendTextField resignFirstResponder];
    [self.DataReceivedTextField resignFirstResponder];
}

-(void)processData:(NSUInteger)dataType {
    switch (dataType) {
        case Adc_DataType:
            NSLog(@"Received ADC data");
            break;
            
        case Pwm_DataType:
            NSLog(@"Received PWM data");
            break;
            
        case Gpio_DataType:
            NSLog(@"Received GPIO data");
            break;
            
        default:
            break;
    }
}

@end
