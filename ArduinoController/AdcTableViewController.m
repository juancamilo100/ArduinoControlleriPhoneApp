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
    
    self.sectionTitles = @[@"Adc Inputs", @"Pwm Outputs"];
    
    self.analog = @{@"Adc Inputs" : self.analogData.adcInputs,
                  @"Pwm Outputs" : self.analogData.pwmOutputs
                  };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionTitles count];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:section];
    NSMutableDictionary *sections = [self.analog objectForKey:sectionTitle];
    
    return [sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adcCell" forIndexPath:indexPath];

//PwmTableViewCell *pwmCell = (PwmTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"adcCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        NSArray *keys = [self.analogData.adcInputs allKeys];
        
        cell.textLabel.text = keys[indexPath.row];

        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.analogData.adcInputs objectForKey:keys[indexPath.row]]];
        
    }
    else if (indexPath.section == 1)
    {
        UISlider *pwmSlider;
        CGRect frame = cell.contentView.frame;
        pwmSlider = [[UISlider alloc] initWithFrame:frame];
        [pwmSlider setBackgroundColor:[UIColor clearColor]];
        pwmSlider.minimumValue = 0.0;
        pwmSlider.maximumValue = 255.0;
        pwmSlider.continuous = YES;
        pwmSlider.value = 175.0;
        
        pwmSlider.bounds = CGRectMake(0, 0, cell.contentView.bounds.size.width/2, pwmSlider.bounds.size.height);
        pwmSlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
        
        NSArray *keys = [self.analogData.pwmOutputs allKeys];
        
        cell.textLabel.text = keys[indexPath.row];
        [cell.contentView addSubview:pwmSlider];
    }
    
    return cell;
}


#pragma mark Delegate Methods
- (void) updateAdcInput:(NSString *)inputNumber withValue:(NSNumber *)value {
    [self.analogData.adcInputs setObject:value forKey:inputNumber];
    
    [self.tableView reloadData];
}

@end
