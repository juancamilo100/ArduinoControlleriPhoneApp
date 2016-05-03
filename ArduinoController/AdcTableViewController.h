//
//  AdcTableViewController.h
//  ArduinoController
//
//  Created by Juan Espinosa on 5/2/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalogData.h"
#import "Protocols.h"

@interface AdcTableViewController : UITableViewController<AdcInputUpdateProtocol, PwmOutputUpdateProtocol>

@property (nonatomic, weak) id <PwmOutputUpdateProtocol> pwmOutputDelegate;
@property (nonatomic, strong) NSMutableArray *sliders;
@property (strong, nonatomic) NSDictionary *analog;
@property (strong, nonatomic) AnalogData *analogData;
@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) UISlider *pwmSlider;

@end
