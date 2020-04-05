//
//  SettingsViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 10.04.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import "SettingsViewController.h"

#import "GenderViewController.h"
#import "CityTableViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)gender:(id)sender {
    GenderViewController *genderViewController = (GenderViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GenderViewController"];
    [self.navigationController pushViewController:genderViewController animated:NO];
}

-(IBAction)city:(id)sender {
    CityTableViewController *genderViewController = (CityTableViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CityTableViewController"];
    [self.navigationController pushViewController:genderViewController animated:NO];
}

@end
