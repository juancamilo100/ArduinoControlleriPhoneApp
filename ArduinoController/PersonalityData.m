//
//  PersonalityData.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/22/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "PersonalityData.h"

@implementation PersonalityData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gpioInputPersonalityData = [[PersonalityEntity alloc] init];
        _gpioOutputPersonalityData = [[PersonalityEntity alloc] init];
        _adcPersonalityData = [[PersonalityEntity alloc] init];
    }
    return self;
}

@end
