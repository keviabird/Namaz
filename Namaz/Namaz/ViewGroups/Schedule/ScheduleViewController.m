//
//  ScheduleViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 25.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ImageUtil.h"
#import "TimerUtil.h"
#import "DataUtil.h"
#import "Schedule.h"
#import "Event.h"
#import "City.h"
#import "CoreData+MagicalRecord.h"
#import "ScheduleTableViewCell.h"

@interface ScheduleViewController() {
    NSArray *entities;
    NSDate *selected;
    
}

@end

@implementation ScheduleViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self updateBackgroundAndSetTimer];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *todayString = [formatter stringFromDate:[NSDate date]];
    selected = [formatter dateFromString:todayString];
    [self.datePicker setMinimumDate:selected];
    self.datePicker.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    City *city = [City MR_findFirstByAttribute:@"id" withValue:[DataUtil getCityId]];
    self.city.text = city.name;
}

-(void)updatePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *todayString = [formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:todayString];
    
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:self.datePicker.frame];
    picker.backgroundColor = [UIColor whiteColor];
    picker.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [picker setMinimumDate:date];
    [picker setDate:selected animated:NO];
    [picker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    picker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker removeFromSuperview];
    self.datePicker = picker;
    [self.view addSubview:self.datePicker];
}

-(void)updateViews {
    NSDate *tomorrow = [selected dateByAddingTimeInterval:24*60*60];
    NSDate *todayNoon = [selected dateByAddingTimeInterval:12*60*60];
    NSDate *tomorrowNoon = [selected dateByAddingTimeInterval:36*60*60];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"event.forSchedule = 1 and ( (date < %@ and date >= %@ and event.id < 9) or (date < %@ and date >= %@ and event.id = 9) )", tomorrow, selected, tomorrowNoon, todayNoon];
    entities = [Schedule MR_findAllSortedBy:@"event.id" ascending:YES withPredicate:predicate];
    [self.tableView reloadData];
    NSDateFormatter *dayFormat = [[NSDateFormatter alloc] init];
    dayFormat.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dayFormat.dateFormat = @"dd";
    [self.day setTitle:[dayFormat stringFromDate:selected] forState:UIControlStateNormal];
    [self.day setTitle:[dayFormat stringFromDate:selected] forState:UIControlStateHighlighted];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormat.dateFormat = @"MMMM yyyy";
    self.date.text = [dateFormat stringFromDate:selected];
    NSDateFormatter *dayOfWeekFormat = [[NSDateFormatter alloc] init];
    dayOfWeekFormat.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dayOfWeekFormat.dateFormat = @"EEEE";
    self.weekday.text = [dayOfWeekFormat stringFromDate:selected];
    dateFormat.dateFormat = @"dd-MM-yyyy";
    self.isToday.hidden = ![[dateFormat stringFromDate:[NSDate date]] isEqualToString:[dateFormat stringFromDate:selected]];
    self.prevButton.hidden = !self.isToday.hidden;
    [self updatePicker];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateBackgroundAndSetTimer];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateViews];
    self.tableView.scrollEnabled = self.tableView.contentSize.height > self.tableView.frame.size.height;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateBackgroundAndSetTimer) object:nil];
}

-(void)updateBackgroundAndSetTimer {
    Schedule *schedule = [TimerUtil getCurrentSchedule];
    NSString *name = [TimerUtil getNameForSchedule:schedule];
    self.mainBackground.image = [ImageUtil resizedImageNamed:name];
    [ImageUtil bluredImage:self.mainBackground];
    NSTimeInterval interval = [schedule.date timeIntervalSinceDate:[NSDate date]];
    [self performSelector:@selector(updateBackgroundAndSetTimer) withObject:nil afterDelay:interval];
}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma Change Date Actions

-(IBAction)previous:(id)sender {
    selected = [selected dateByAddingTimeInterval:-24*60*60];
    [self updateViews];
}

-(IBAction)next:(id)sender {
    selected = [selected dateByAddingTimeInterval:24*60*60];
    [self updateViews];
}

-(IBAction)changeDate:(id)sender {
    self.closePicker.hidden = NO;
    [self.datePicker setDate:selected animated:NO];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    CGRect rect = self.datePicker.frame;
    rect.origin.y = self.view.frame.size.height - self.datePicker.frame.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        self.datePicker.frame = rect;
    }];
}

-(IBAction)closeDatePicker:(id)sender {
    self.closePicker.hidden = YES;
    CGRect rect = self.datePicker.frame;
    rect.origin.y = self.view.frame.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        self.datePicker.frame = rect;
    }];
}

-(IBAction)datePickerValueChanged:(id)sender {
    selected = self.datePicker.date;
    [self updateViews];
}

#pragma mark
#pragma Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [entities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleCell"];
    if (cell == nil) {
        cell = [[ScheduleTableViewCell alloc] init];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"HH:mm";
    cell.textLabel.text = [[(Schedule *)[entities objectAtIndex:indexPath.row] event] name];
    cell.detailTextLabel.text = [formatter stringFromDate:[(Schedule *)[entities objectAtIndex:indexPath.row] date]];
    if (indexPath.row == [entities count] - 1) {
        cell.line.hidden = YES;
    }
    return cell;
}

@end
