//
//  TutorialViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 10.03.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import "GreetingsViewController.h"
#import "ImageUtil.h"
#import "DataUtil.h"

@interface GreetingsViewController ()

@end

@implementation GreetingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainBackground.image = [ImageUtil resizedImageNamed:@"Hello"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [DataUtil setGreetings:@"done"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
