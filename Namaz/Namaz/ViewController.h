//
//  ViewController.h
//  Namaz
//
//  Created by Elena Gracheva on 01.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mainBackground;
@property (weak, nonatomic) IBOutlet UILabel *preryerName;
@property (weak, nonatomic) IBOutlet UILabel *timeLeft;

-(IBAction)tutorialPressed:(id)sender;
-(IBAction)compassPressed:(id)sender;
-(IBAction)schedulePressed:(id)sender;
-(IBAction)newsPressed:(id)sender;

@end

