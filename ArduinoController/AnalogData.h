//
//  AdcData.h
//  ArduinoController
//
//  Created by Juan Espinosa on 5/2/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalogData : NSObject

@property (strong, nonatomic) NSMutableDictionary *adcInputs;
@property (strong, nonatomic) NSMutableDictionary *pwmOutputs;

- (void) initAdcInputsWithData:(NSMutableArray *)adcInputsData;
- (void) initPwmOutputsWithData:(NSMutableArray *)pwmOutputsData;

@end
