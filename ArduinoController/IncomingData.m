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

#define ADC_DATA (@"ADC")
#define PWM_DATA (@"PWM")
#define GPIO_DATA (@"GPIO")

@implementation IncomingData

- (instancetype)initWithString:(NSString *)data
{
    self = [super init];
    if (self) {
        NSArray *parsingArray = [data componentsSeparatedByString: @":"];
        
        _payload = [[NSMutableArray alloc] init];
        
        _type = [parsingArray objectAtIndex:0];
        
        for (int i = 1; i < [parsingArray count]; i++) {
            _payload[i - 1] = [parsingArray objectAtIndex:i];
        }
    }
    
    return self;
}

- (NSUInteger)getDataType {
    
    SWITCH (self.type) {
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

@end
