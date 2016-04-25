//
//  GPIOTableViewController.m
//  ArduinoController
//
//  Created by Juan Espinosa on 4/25/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "GPIOTableViewController.h"

@interface GPIOTableViewController ()


@end

@implementation GPIOTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionTitles = @[@"Inputs", @"Outputs"];
    
    self.gpio = @{@"Inputs" : self.gpioData.inputs,
                  @"Outputs" : self.gpioData.outputs
                  };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:section];
    NSMutableDictionary *sections = [self.gpio objectForKey:sectionTitle];
    
    return [sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitles objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gpio" forIndexPath:indexPath];
    
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:indexPath.section];
    NSMutableDictionary *gpioDictionary = [self.gpio objectForKey:sectionTitle];
    
    NSArray *keys = [gpioDictionary allKeys];
    
    NSString *gpioNumber = [NSString stringWithFormat:@"Pin %@",keys[indexPath.row]];

    cell.textLabel.text = gpioNumber;
    if (indexPath.section == 0) {
        cell.detailTextLabel.text = ([[gpioDictionary objectForKey:keys[indexPath.row]] integerValue]) ? @"RELEASED" : @"PRESSED";
    }
    else if (indexPath.section == 1)
    {
        cell.detailTextLabel.text = ([[gpioDictionary objectForKey:keys[indexPath.row]] integerValue]) ? @"HIGH" : @"LOW";
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NSLog(@"Activated an output");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Delegate Methods
- (void) updateDigitalInput:(NSString *)inputNumber withValue:(NSNumber *)state {
    NSLog(@"Pin number is: %@ and State is: %@", inputNumber, state);
    [self.gpioData.inputs setObject:state forKey:inputNumber];
    
    [self.tableView reloadData];
}

@end
