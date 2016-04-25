//
//  GpioData.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/25/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "GpioData.h"

@implementation GpioData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _inputs = [[NSMutableDictionary alloc] init];
        _outputs = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) initInputsWithData:(NSMutableArray *)inputsData {

    for (int i = 0; i < [inputsData count]; i++)
    {
        [self.inputs setObject:[NSNumber numberWithInt:0] forKey:inputsData[i]];
    }
}

- (void) initOutputsWithData:(NSMutableArray *)outputsData {
    
    for (int i = 0; i < [outputsData count]; i++)
    {
        [self.outputs setObject:[NSNumber numberWithInt:0] forKey:outputsData[i]];
    }
}


@end
