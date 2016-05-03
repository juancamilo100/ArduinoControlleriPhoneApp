//
//  GPIOTableViewController.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/25/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalityData.h"
#import "GpioData.h"
#import "ViewController.h"
#import "Protocols.h"

@interface GPIOTableViewController : UITableViewController<GpioInputUpdateProtocol>

@property (nonatomic, weak) id <GpioOutputUpdateProtocol> delegate;
@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) NSDictionary *gpio;
@property (strong, nonatomic) GpioData *gpioData;

@end
