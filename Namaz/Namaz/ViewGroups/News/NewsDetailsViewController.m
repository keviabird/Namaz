//
//  NewsDetailsViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 15.06.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import "News.h"

@interface NewsDetailsViewController ()

@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.head.text = self.news.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"dd MMMM yyyy HH:mm";
    self.date.text = [formatter stringFromDate:self.news.date];
    self.picture.image = [UIImage imageWithData:self.news.fullImage];
    self.scrollView.frame = self.view.frame;
    self.text.text = self.news.text;
    [self.text setNumberOfLines:0];
    [self.text setLineBreakMode:NSLineBreakByWordWrapping];
    CGSize maximumLabelSize = CGSizeMake(self.view.frame.size.width - 14,9999);
    CGSize expectSize = [self.text sizeThatFits:maximumLabelSize];
    self.textHeightConstraint.constant = expectSize.height;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
