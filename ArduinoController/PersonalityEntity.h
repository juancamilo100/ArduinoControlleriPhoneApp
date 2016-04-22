//
//  PersonalityEntity.h
//  ArduinoController
//
//  Created by Juan Espinosa on 4/22/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalityEntity : NSObject

@property NSNumber *numberOfAvailablePins;
@property (strong, nonatomic) NSMutableArray* availablePinNumbers;

@end
