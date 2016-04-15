//
//  IncomingData.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/15/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IncomingData : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *payload;

@end
