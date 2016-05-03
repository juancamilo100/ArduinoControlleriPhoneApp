//
//  GpioData.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/25/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GpioData : NSObject

@property (strong, nonatomic) NSMutableDictionary *inputs;
@property (strong, nonatomic) NSMutableDictionary *outputs;

- (void) initInputsWithData:(NSMutableArray *)inputsData;
- (void) initOutputsWithData:(NSMutableArray *)outputsData;

@end
