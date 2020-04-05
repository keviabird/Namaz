//
//  NewsViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 07.06.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NewsDetailsViewController.h"
#import "SynchronizationServices.h"
#import "ImageUtil.h"
#import "TimerUtil.h"
#import "Schedule.h"
#import "News.h"
#import "CoreData+MagicalRecord.h"
#import "Const.h"

@interface NewsViewController () {
    NSArray *entities;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateBackgroundAndSetTimer];
    [self update];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(synchronize)
                  forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:self.refreshControl];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateBackgroundAndSetTimer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update) name:NAMAZ_UPDATE_SUCCEEDED_NOTIFICATION object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateBackgroundAndSetTimer) object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)synchronize {
    [SynchronizationServices synchronize];
}

-(void)update {
    NSFetchRequest *request = [News MR_requestAll];
    request.sortDescriptors = [NSMutableArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES], [[NSSortDescriptor alloc] initWithKey:@"important" ascending:NO], nil];
    entities = [News MR_executeFetchRequest:request];
    [self.table reloadData];
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([entities count] > 0) {
        return 1;
    } else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = @"Новостей пока нет. Потяните вниз, чтобы обновить.";
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:16];
        [messageLabel sizeToFit];
        
        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [entities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = [entities objectAtIndex:indexPath.row];
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc] init];
    }
    cell.image.image = [UIImage imageWithData:news.smallImage];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"dd MMMM yyyy HH:mm";
    cell.date.text = [formatter stringFromDate:news.date];
    cell.title.text = news.title;
    return cell;
}

#pragma mark
#pragma Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width / 2 + 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewsDetailsViewController"];
    vc.news = [entities objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
