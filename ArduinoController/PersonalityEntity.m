//
//  PersonalityEntity.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/22/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "PersonalityEntity.h"

@implementation PersonalityEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        _availablePinNumbers = [[NSMutableArray alloc] init];
        _numberOfAvailablePins = 0;
        
    }
    return self;
}

@end
