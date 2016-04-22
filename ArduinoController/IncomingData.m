//
//  IncomingData.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/15/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "IncomingData.h"

#define CASE(str)   if ([__s__ isEqualToString:(str)])
#define SWITCH(s)   for (NSString *__s__ = (s); ; )
#define DEFAULT
#define GPIO_NUMBER_OF_AVAILABLE_PINS_INDEX (1)
#define GPIO_AVAILABLE_PINS_INDEX (2)

#define ADC_DATA (@"ADC")
#define PWM_DATA (@"PWM")
#define GPIO_DATA (@"GPIO")
#define PERSONALITY_DATA (@"PERS")

@implementation IncomingData

- (instancetype)initWithString:(NSString *)data
{
    self = [super init];
    if (self) {
        NSArray *parsingArray = [data componentsSeparatedByString: @":"];
        
        _payload = [[NSMutableArray alloc] init];
        _gpioInputPersonalityData = [[PersonalityEntity alloc] init];
        _gpioOutputPersonalityData = [[PersonalityEntity alloc] init];
    
        _command = [parsingArray objectAtIndex:0];
        _subCommand = [parsingArray objectAtIndex:1];
        
        for (int i = 1; i < [parsingArray count]; i++) {
           _payload[i - 1] = [parsingArray objectAtIndex:i];
        }
    }
    
    return self;
}

- (NSUInteger)getCommand {
    
    SWITCH (self.command) {
        
        CASE (PERSONALITY_DATA) {
            return Personality_DataType;
            break;
        }
        
        CASE (ADC_DATA) {
            return Adc_DataType;
            break;
        }
        CASE (PWM_DATA) {
            return Pwm_DataType;
            break;
        }
        CASE (GPIO_DATA) {
            return Gpio_DataType;
            break;
        }
        DEFAULT {
            return Max_DataType;
            break;
        }
    }
}

- (NSString *)getSubCommand {
    return self.subCommand;
}

- (PersonalityEntity *) getGpioInputPersonalityData {
    
    self.gpioInputPersonalityData.numberOfAvailablePins = [self.payload objectAtIndex:GPIO_NUMBER_OF_AVAILABLE_PINS_INDEX];
    
    self.gpioInputPersonalityData.availablePinNumbers = (NSMutableArray *)[[self.payload objectAtIndex:GPIO_AVAILABLE_PINS_INDEX] componentsSeparatedByString: @","];
    
    return self.gpioInputPersonalityData;
}

- (PersonalityEntity *) getGpioOutputPersonalityData {
    self.gpioOutputPersonalityData.numberOfAvailablePins = [self.payload objectAtIndex:GPIO_NUMBER_OF_AVAILABLE_PINS_INDEX];
    
    self.gpioOutputPersonalityData.availablePinNumbers = (NSMutableArray *)[[self.payload objectAtIndex:GPIO_AVAILABLE_PINS_INDEX] componentsSeparatedByString: @","];
    
    return self.gpioOutputPersonalityData;
}

@end
