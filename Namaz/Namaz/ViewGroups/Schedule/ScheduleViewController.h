//
//  ScheduleViewController.h
//  Namaz
//
//  Created by Elena Gracheva on 25.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UIImageView *mainBackground;
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,weak) IBOutlet UILabel *city;
@property(nonatomic,weak) IBOutlet UIButton *day;
@property(nonatomic,weak) IBOutlet UIButton *prevButton;
@property(nonatomic,weak) IBOutlet UIButton *nextButton;
@property(nonatomic,weak) IBOutlet UILabel *date;
@property(nonatomic,weak) IBOutlet UILabel *weekday;
@property(nonatomic,weak) IBOutlet UILabel *isToday;
@property(nonatomic,weak) IBOutlet UIDatePicker *datePicker;
@property(nonatomic,weak) IBOutlet UIButton *closePicker;

-(IBAction)back:(id)sender;

-(IBAction)previous:(id)sender;
-(IBAction)next:(id)sender;
-(IBAction)changeDate:(id)sender;
-(IBAction)closeDatePicker:(id)sender;
-(IBAction)datePickerValueChanged:(id)sender;

@end
