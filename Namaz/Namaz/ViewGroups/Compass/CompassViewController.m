//
//  CompassViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 14.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "CompassViewController.h"
#import "ImageUtil.h"
#import "CompassUtil.h"
#import "Schedule.h"
#import "TimerUtil.h"


@implementation CompassViewController

@synthesize locationManager;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    locationManager = [[CLLocationManager alloc] init];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    locationManager.delegate = self;
    
    // Start heading updates.
    
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 5;
        [locationManager startUpdatingHeading];
    }
    
    [locationManager startUpdatingLocation];
    
    [self updateBackgroundAndSetTimer];
    
    UIImage *compassImage = [UIImage imageNamed:@"compass_view"];
    self.compassView.image = compassImage;
    self.compassView.transform = CGAffineTransformMakeRotation([CompassUtil angleFromLocation:locationManager.location.coordinate andHeading:locationManager.heading.trueHeading]);
    
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

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
    [UIView animateWithDuration:0.3 animations:^{
        self.compassView.transform = CGAffineTransformMakeRotation([CompassUtil angleFromLocation:manager.location.coordinate andHeading:theHeading]);
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        CLLocationDirection  theHeading = ((manager.heading.trueHeading > 0) ? manager.heading.trueHeading : manager.heading.magneticHeading);
        self.compassView.transform = CGAffineTransformMakeRotation([CompassUtil angleFromLocation:location.coordinate andHeading:theHeading]);
    }];
}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
