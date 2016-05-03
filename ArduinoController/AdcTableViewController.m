//
//  AdcTableViewController.m
//  ArduinoController
//
//  Created by Juan Espinosa on 5/2/16.
//  Copyright © 2016 Juan Espinosa. All rights reserved.
//

#import "AdcTableViewController.h"

#define PWM_SLIDER_MAX_VALUE (255.0)
#define PWM_SLIDER_MIN_VALUE (0.0)

@interface AdcTableViewController ()

@end

@implementation AdcTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionTitles = @[@"Adc Inputs", @"Pwm Outputs"];
    self.sliders = [[NSMutableArray alloc] init];
    
    self.analog = @{@"Adc Inputs" : self.analogData.adcInputs,
                  @"Pwm Outputs" : self.analogData.pwmOutputs
                  };
    self.pwmOutputDelegate = [self.navigationController.viewControllers objectAtIndex:0];
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
    
    if (indexPath.section == 0) {
        NSArray *keys = [self.analogData.adcInputs allKeys];
        
        cell.textLabel.text = keys[indexPath.row];

        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.analogData.adcInputs objectForKey:keys[indexPath.row]]];
        
    }
    else if (indexPath.section == 1)
    {
        CGRect frame = cell.contentView.frame;
        self.pwmSlider = [[UISlider alloc] initWithFrame:frame];\
        self.pwmSlider.minimumValue = PWM_SLIDER_MIN_VALUE;
        self.pwmSlider.maximumValue = PWM_SLIDER_MAX_VALUE;
        self.pwmSlider.continuous = YES;
        //        pwmSlider.value = 175.0;
        self.pwmSlider.tag = indexPath.row;
        [self.sliders insertObject:@(self.pwmSlider.value) atIndex:self.pwmSlider.tag];
        
        self.pwmSlider.bounds = CGRectMake(0, 0, cell.contentView.bounds.size.width/2, self.pwmSlider.bounds.size.height);
        self.pwmSlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));

        NSArray *keys = [self.analogData.pwmOutputs allKeys];
        
        cell.textLabel.text = keys[indexPath.row];
//        float percentageValue = ([self.sliders[indexPath.row] integerValue] / PWM_SLIDER_MAX_VALUE)*100;
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%f%@ ",percentageValue, @"%"];
        [cell.contentView addSubview:self.pwmSlider];
        
        [self.pwmSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];

        return cell;
    }
    
    return cell;
}


#pragma mark Delegate Methods
- (void) updateAdcInput:(NSString *)inputNumber withValue:(NSNumber *)value {
    [self.analogData.adcInputs setObject:value forKey:inputNumber];
    
    [self.tableView reloadData];
}

- (void)sliderChanged:(UISlider *)slider
{
    NSArray *keys = [self.analogData.pwmOutputs allKeys];
    
    NSInteger pinNumber = [keys[slider.tag] integerValue];
    [self.pwmOutputDelegate updatePwmOutput:pinNumber withValue:slider.value];
//    [self.sliders insertObject:@(slider.value) atIndex:slider.tag];

}

@end
