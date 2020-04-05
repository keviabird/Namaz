//
//  TutorialTableViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 18.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "TutorialViewController.h"
#import "ImageUtil.h"
#import "Schedule.h"
#import "Event.h"
#import "TimerUtil.h"
#import "CoreData+MagicalRecord.h"
#import "TutorialTableViewCell.h"

@interface TutorialViewController() {
    NSArray *entities;
}
@end

@implementation TutorialViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self updateBackgroundAndSetTimer];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"forTutorial = 1"];
    entities = [Event MR_findAllSortedBy:@"id" ascending:YES withPredicate:predicate];
    self.tableView.scrollEnabled = self.tableView.contentSize.height > self.tableView.frame.size.height;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateBackgroundAndSetTimer];
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
#pragma Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [entities count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TutorialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TutorialCell"];
    if (cell == nil) {
        cell = [[TutorialTableViewCell alloc] init];
    }
    cell.nameLabel.text = [(Event *)[entities objectAtIndex:indexPath.row] name];
    if (indexPath.row == [entities count] - 1) {
        cell.line.hidden = YES;
    }
    return cell;
}


@end
