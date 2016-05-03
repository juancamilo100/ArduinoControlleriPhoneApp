//
//  AdcData.m
//  ArduinoController
//
//  Created by Juan Espinosa on 5/2/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "AnalogData.h"

@implementation AnalogData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _adcInputs = [[NSMutableDictionary alloc] init];
        _pwmOutputs = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) initAdcInputsWithData:(NSMutableArray *)inputsData {
    
    for (int i = 0; i < [inputsData count]; i++)
    {
        [self.adcInputs setObject:[NSNumber numberWithInt:0] forKey:inputsData[i]];
    }
}

- (void) initPwmOutputsWithData:(NSMutableArray *)pwmOutputsData {
    
    for (int i = 0; i < [pwmOutputsData count]; i++)
    {
        [self.pwmOutputs setObject:[NSNumber numberWithInt:0] forKey:pwmOutputsData[i]];
    }
}

@end
