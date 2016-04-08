//
//  ViewController.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/8/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreBluetooth;
@import QuartzCore;

@interface ViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral     *HM10Peripheral;

@property (strong, nonatomic) NSMutableDictionary *devices;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;
@property (strong, nonatomic) CBPeripheral *selectedPeripheral;
@property (strong, nonatomic) CBCharacteristic *characteristics;
@property (nonatomic, retain) NSString *rxData;

@end

