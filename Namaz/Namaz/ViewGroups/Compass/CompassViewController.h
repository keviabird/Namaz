//
//  CompassViewController.h
//  Namaz
//
//  Created by Elena Gracheva on 14.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CompassViewController : UIViewController <CLLocationManagerDelegate>

@property(nonatomic,weak) IBOutlet UIImageView *mainBackground;
@property(nonatomic,weak) IBOutlet UIImageView *compassView;
@property(nonatomic) CLLocationManager *locationManager;

-(IBAction)back:(id)sender;

@end
