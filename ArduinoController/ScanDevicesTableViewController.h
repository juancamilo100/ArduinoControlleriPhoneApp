//
//  ScanDevicesViewControllerTableViewController.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/14/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreBluetooth;
@import QuartzCore;

@protocol DeviceSelectionDelegate

- (void)bluetoothDeviceSelected:(CBPeripheral *)peripheral withCentralManager:(CBCentralManager *)central;

@end

@interface ScanDevicesTableViewController : UITableViewController <CBCentralManagerDelegate>

@property (nonatomic, weak) id <DeviceSelectionDelegate> deviceSelectionDelegate;
@property (nonatomic, weak) id <CBPeripheralDelegate> peripheralManagerDelegate;
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) NSMutableArray *discoveredPeripherals;
@property double numberOfPeripheralsFound;

@end
