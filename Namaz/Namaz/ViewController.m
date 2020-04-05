//
//  ViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 01.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "ViewController.h"
#import "ImageUtil.h"
#import "TutorialViewController.h"
#import "CompassViewController.h"
#import "ScheduleViewController.h"
#import "NewsViewController.h"

#import "Event.h"
#import "Schedule.h"
#import "CoreData+MagicalRecord.h"
#import "TimerUtil.h"
#import "DataUtil.h"

#import "CityTableViewController.h"
#import "GenderViewController.h"
#import "GreetingsViewController.h"

@interface ViewController () {
    NSTimer *timer;
    Schedule *schedule;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    schedule = [TimerUtil getCurrentSchedule];
    NSString *name = [TimerUtil getNameForSchedule:schedule];
    self.mainBackground.image = [ImageUtil resizedImageNamed:name];
    self.preryerName.text = [self getTitleForSchedule];
    self.timeLeft.text = [TimerUtil stringFromTimeInterval:[schedule.date timeIntervalSinceDate:[NSDate date]]];
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkTime) userInfo:nil repeats:YES];
        [timer fire];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkTime];
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkTime) userInfo:nil repeats:YES];
        [timer fire];
    }
    NSNumber *cityId = [DataUtil getCityId];
//    if ([cityId isEqualToNumber:@0]) {
//        CityTableViewController *cityTableViewController = (CityTableViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CityTableViewController"];
//        [self.navigationController pushViewController:cityTableViewController animated:NO];
//    }
    NSString *gender = [DataUtil getGender];
    if (gender == nil) {
        GenderViewController *genderViewController = (GenderViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GenderViewController"];
        [self.navigationController pushViewController:genderViewController animated:NO];
    }
    NSString *greetings = [DataUtil getGreetings];
    if (greetings == nil) {
        GreetingsViewController *greetingsViewController = (GreetingsViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GreetingsViewController"];
        [self.navigationController pushViewController:greetingsViewController animated:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

-(void)checkTime {
    Schedule *next = [TimerUtil getCurrentSchedule];
    if (![next isEqual:schedule]) {
        NSString *name = [TimerUtil getNameForSchedule:next];
        self.mainBackground.image = [ImageUtil resizedImageNamed:name];
        schedule = next;
    }
    self.preryerName.text = [self getTitleForSchedule];
    self.timeLeft.text = [TimerUtil stringFromTimeInterval:[next.date timeIntervalSinceDate:[NSDate date]]];
}

-(NSString *)getTitleForSchedule {
    NSString *result = (schedule == nil) ? @"Нет Вашего города? Напишите письмо на info@rakaat.ru с названием города и мы обязательно рассмотрим возможность включения Вашего города в перечень" : [NSString stringWithFormat:@"Осталось времени до %@", schedule.event.name];
    return result;
}


-(IBAction)tutorialPressed:(id)sender {
    TutorialViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)compassPressed:(id)sender {
    CompassViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CompassViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)schedulePressed:(id)sender {
    ScheduleViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ScheduleViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)newsPressed:(id)sender {
    NewsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewsViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
