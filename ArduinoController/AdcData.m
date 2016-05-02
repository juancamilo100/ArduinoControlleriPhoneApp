//
//  AdcData.m
//  ArduinoController
//
//  Created by Juan Espinosa on 5/2/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "AdcData.h"

@implementation AdcData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _adcInputs = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) initAdcInputsWithData:(NSMutableArray *)inputsData {
    
    for (int i = 0; i < [inputsData count]; i++)
    {
        [self.adcInputs setObject:[NSNumber numberWithInt:0] forKey:inputsData[i]];
    }
}

@end
