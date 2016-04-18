//
//  ScanDevicesViewControllerTableViewController.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/14/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "ScanDevicesTableViewController.h"

#define HM10_UUID "C1BB0955-4160-7B39-2694-D5277D2015CE"

@interface ScanDevicesTableViewController ()

@end

@implementation ScanDevicesTableViewController

static NSArray *uuidAccepted = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    self.tableView.tableHeaderView = headerView;
    
    uuidAccepted = [NSArray arrayWithObjects:@HM10_UUID, nil];
    
    self.numberOfPeripheralsFound = 0;
    self.discoveredPeripherals = [[NSMutableArray alloc] init];
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"Appearded");
}

#pragma mark - CBCentralManagerDelegate

// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [self.deviceSelectionDelegate bluetoothDeviceSelected:peripheral withCentralManager:self.centralManager];
    NSLog(@"Connected");
    [self.centralManager stopScan];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *uuid = [[peripheral identifier] UUIDString];
    NSString *peripheralName = [peripheral name];
//    
//    NSLog(@"uuid = %@", uuid);
//    NSLog(@"Peripheral Name = %@", peripheralName);
//    
//    NSLog(@"uuid is in accepted devices: %@, ", [uuidAccepted containsObject: uuid] ? @"YES" : @"NO");
//    NSLog(@"uuid is already in the array: %@, ", [self.discoveredPeripherals containsObject:uuid] ? @"YES" : @"NO");
    
    if (([uuidAccepted containsObject: uuid]) &&
        (![self.discoveredPeripherals containsObject:uuid])) {
        [self.discoveredPeripherals addObject:peripheral];
    }

    [self.tableView reloadData];
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
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.discoveredPeripherals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discoveredDevice" forIndexPath:indexPath];
    
    CBPeripheral *peripheral = self.discoveredPeripherals[indexPath.row];
    
    if ([[peripheral name] isEqual: [NSNull null]]) {
        cell.textLabel.text = [[peripheral identifier] UUIDString];
    }
    else{
        cell.textLabel.text = [peripheral name];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CBPeripheral *peripheral = self.discoveredPeripherals[indexPath.row];
    
    [self.centralManager connectPeripheral:peripheral options:nil];

    NSLog(@"Name of peripheral selected: %@", [peripheral name]);
}

//Swipe down to dismiss the device scan modal view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= -90) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
