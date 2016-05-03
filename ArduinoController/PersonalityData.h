//
//  PersonalityData.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/22/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalityEntity.h"

@interface PersonalityData : NSObject

@property (nonatomic, strong) PersonalityEntity *gpioInputPersonalityData;
@property (nonatomic, strong) PersonalityEntity *gpioOutputPersonalityData;
@property (nonatomic, strong) PersonalityEntity *adcPersonalityData;
@property (nonatomic, strong) PersonalityEntity *pwmPersonalityData;


@end
