//
//  AdcData.h
//  ArduinoController
//
//  Created by Juan Espinosa on 5/2/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdcData : NSObject

@property (strong, nonatomic) NSMutableDictionary *adcInputs;

- (void) initAdcInputsWithData:(NSMutableArray *)inputsData;

@end
