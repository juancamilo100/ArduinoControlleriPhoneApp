//
//  Protocols.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/27/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GpioOutputUpdateProtocol

- (void) updateDigitalOutput:(NSInteger)outputNumber withValue:(NSInteger)state;

@end

@protocol GpioInputUpdateProtocol

- (void) updateDigitalInput:(NSNumber *)inputNumber withValue:(NSNumber *)state;

@end

@protocol AdcInputUpdateProtocol

- (void) updateAdcInput:(NSNumber *)inputNumber withValue:(NSNumber *)value;

@end

@interface Protocols : NSObject

@end
