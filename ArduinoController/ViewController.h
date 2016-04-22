//
//  ViewController.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/8/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanDevicesTableViewController.h"
#import "IncomingData.h"
#import "PersonalityData.h"

@import CoreBluetooth;
@import QuartzCore;

@interface ViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate, DeviceSelectionDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral     *HM10Peripheral;

@property (strong, nonatomic) NSMutableDictionary *devices;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;
@property (strong, nonatomic) CBPeripheral *selectedPeripheral;
@property (strong, nonatomic) CBCharacteristic *characteristics;

@property (strong, nonatomic) IncomingData *dataReceived;
@property (strong, nonatomic) PersonalityData *personality;

@property (weak, nonatomic) IBOutlet UITextView *DataReceivedTextField;
@property (weak, nonatomic) IBOutlet UIButton *ScanForDevicesButton;
@property (weak, nonatomic) IBOutlet UITextField *SendTextField;

- (IBAction)SendButton:(id)sender;
@end

