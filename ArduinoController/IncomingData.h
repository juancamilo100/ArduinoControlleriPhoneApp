//
//  IncomingData.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/15/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalityEntity.h"

typedef enum : NSUInteger {
    Adc_DataType,
    Pwm_DataType,
    Gpio_DataType,
    Personality_DataType,
    Max_DataType
} DataType;

@interface IncomingData : NSObject

@property (nonatomic, strong) NSMutableArray *payload;
@property (nonatomic, strong) NSString *command;
@property (nonatomic, strong) NSString *subCommand;
@property (nonatomic, strong) PersonalityEntity *gpioInputPersonalityData;
@property (nonatomic, strong) PersonalityEntity *gpioOutputPersonalityData;
@property (nonatomic, strong) PersonalityEntity *adcPersonalityData;


- (instancetype)initWithString:(NSString *)data;
- (NSUInteger)getCommand;
- (NSString *)getSubCommand;
- (PersonalityEntity *) getGpioInputPersonalityData;
- (PersonalityEntity *) getGpioOutputPersonalityData;
- (PersonalityEntity *) getAdcPersonalityData;

@end
