//
//  ViewController.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/8/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "ViewController.h"

#define HM10_UUID "0000ffe0-0000-1000-8000-00805f9b34fb"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CBCentralManagerDelegate

// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Connected");
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil]; //ask the peripheral to discover the services associated with the peripheral device

    NSLog(@"Connected");
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    NSString * uuid = [[peripheral identifier] UUIDString];
    
    NSLog(@"UUID of discovered peripheral service is: %@", uuid);
    NSLog(@"Name of discovered peripheral: %@", [peripheral name]);
    [self.centralManager connectPeripheral:peripheral options:nil];
    NSLog(@"Connecting...");
    [self.centralManager stopScan];
    
    if ([uuid isEqualToString:@HM10_UUID]) {
        NSLog(@"Found peripheral: %@", localName);
        [self.centralManager stopScan];
        self.HM10Peripheral = peripheral;
        peripheral.delegate = self;
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
        // Scan for devices
        [_centralManager scanForPeripheralsWithServices:nil options:nil];
        NSLog(@"Scanning started...");
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
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
    double numberOfCharacteristics = 0;
    for (CBCharacteristic * characteristic in [service characteristics])
    {
        // Discover all descriptors for each characteristic.
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        numberOfCharacteristics++;
    }
    
    NSLog(@"Number of characteristics = %.1f", numberOfCharacteristics);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    const char * bytes =[(NSData*)[[characteristic UUID] data] bytes];
    if (bytes && strlen(bytes) == 2 && bytes[0] == (char)255 && bytes[1] == (char)225)
    {
        for (CBService * service in [self.selectedPeripheral services])
        {
            
            for (CBCharacteristic * characteristic in [service characteristics])
            {
                // For every characteristic on every service, on the connected peripheral
                // set the setNotifyValue to true.
                NSLog(@"%c", bytes[1]);
                
                [peripheral setNotifyValue:true forCharacteristic:characteristic];
            }
        }
    }
}

/***** RECEIVE DATA *******/
// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString * str = [[NSString alloc] initWithData:[characteristic value] encoding:NSUTF8StringEncoding];
    self.rxData = str;
    NSLog(@"Received data = %@", str);
}

/***** SEND DATA *******/
- (void)sendValue:(NSString *) str
{
    NSString *strData = [NSString stringWithFormat:@"%@:", str];
    for (CBService * service in [self.HM10Peripheral services])
    {
        for (CBCharacteristic * characteristic in [service characteristics])
        {
            [self.HM10Peripheral writeValue:[strData dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
        }
    }
}


@end