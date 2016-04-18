//
//  IncomingData.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/15/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Adc_DataType,
    Pwm_DataType,
    Gpio_DataType,
    Max_DataType
} DataType;

@interface IncomingData : NSObject

@property (nonatomic, strong) NSMutableArray *payload;
@property (nonatomic, strong) NSString *type;

- (instancetype)initWithString:(NSString *)data;
- (NSUInteger)getDataType;

@end
