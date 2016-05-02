//
//  AdcTableViewController.h
//  ArduinoController
//
//  Created by Juan Espinosa on 5/2/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdcData.h"
#import "Protocols.h"

@interface AdcTableViewController : UITableViewController<AdcInputUpdateProtocol>

@property (strong, nonatomic) AdcData *adcData;

@end
