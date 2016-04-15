//
//  IncomingData.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/15/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "IncomingData.h"

@implementation IncomingData

- (instancetype)initWithString:(NSString *)data
{
    self = [super init];
    if (self) {
        NSArray *parsingArray = [data componentsSeparatedByString: @":"];
        NSMutableArray
        
        self.type = [parsingArray objectAtIndex:0];
        
        for (int i = 0; i < [parsingArray count]; i++) {
            self.
        }
    }
    
    return self;
}

@end
