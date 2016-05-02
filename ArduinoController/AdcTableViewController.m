//
//  AdcTableViewController.m
//  ArduinoController
//
//  Created by Juan Espinosa on 5/2/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "AdcTableViewController.h"

@interface AdcTableViewController ()

@end

@implementation AdcTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.adcData.adcInputs count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"ADC Inputs";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adcCell" forIndexPath:indexPath];
    
    NSArray *keys = [self.adcData.adcInputs allKeys];
    NSLog(@"Keys = %@", keys);
    
    cell.textLabel.text = keys[indexPath.row];
//    NSLog(@"Value = %@", (NSString *)[self.adcData.adcInputs objectForKey:keys[indexPath.row]]);
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.adcData.adcInputs objectForKey:keys[indexPath.row]]];
    
    return cell;
}


#pragma mark Delegate Methods
- (void) updateAdcInput:(NSString *)inputNumber withValue:(NSNumber *)value {
    NSLog(@"Pin number is: %@ and Value is: %@", inputNumber, value);
    [self.adcData.adcInputs setObject:value forKey:inputNumber];
    
    [self.tableView reloadData];
}

@end