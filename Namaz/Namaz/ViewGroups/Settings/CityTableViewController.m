//
//  CityTableViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 17.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import "CityTableViewController.h"
#import "Schedule.h"
#import "TimerUtil.h"
#import "ImageUtil.h"
#import "TutorialTableViewCell.h"
#import "City.h"
#import "CoreData+MagicalRecord.h"
#import "DataUtil.h"
#import "Const.h"
#import "SynchronizationServices.h"

@interface CityTableViewController () {
    
    NSArray *entities;
}

@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateBackgroundAndSetTimer];
    [self updateView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateView) name:NAMAZ_UPDATE_SUCCEEDED_NOTIFICATION object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateView {
    entities = [City MR_findAllSortedBy:@"name" ascending:YES];
    [self.tableView reloadData];
}

-(void)updateBackgroundAndSetTimer {
    Schedule *schedule = [TimerUtil getCurrentSchedule];
    NSString *name = [TimerUtil getNameForSchedule:schedule];
    self.mainBackground.image = [ImageUtil resizedImageNamed:name];
    [ImageUtil bluredImage:self.mainBackground];
    NSTimeInterval interval = [schedule.date timeIntervalSinceDate:[NSDate date]];
    [self performSelector:@selector(updateBackgroundAndSetTimer) withObject:nil afterDelay:interval];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.hidden = ([entities count] == 0);
    self.activityIndicator.hidden = !self.tableView.hidden;
    return [entities count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TutorialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TutorialCell"];
    if (cell == nil) {
        cell = [[TutorialTableViewCell alloc] init];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"HH:mm";
    cell.nameLabel.text = [(City *)[entities objectAtIndex:indexPath.row] name];
    if (indexPath.row == [entities count] - 1) {
        cell.line.hidden = YES;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [DataUtil setCityId:[(City *)[entities objectAtIndex:indexPath.row] id]];
    [DataUtil setLastUpdated:@0];
    [SynchronizationServices synchronize];
    self.tableView.hidden = YES;
    self.activityIndicator.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

@end
