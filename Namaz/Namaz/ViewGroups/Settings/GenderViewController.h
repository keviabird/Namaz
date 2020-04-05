//
//  GenderViewController.h
//  Namaz
//
//  Created by Elena Gracheva on 17.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenderViewController : UIViewController

@property(nonatomic,weak) IBOutlet UIImageView *mainBackground;
@property(nonatomic,weak) IBOutlet UIButton *man;
@property(nonatomic,weak) IBOutlet UIButton *woman;

@property(nonatomic,weak) IBOutlet UILabel *manTitle;
@property(nonatomic,weak) IBOutlet UILabel *womanTitle;

-(IBAction)back:(id)sender;

-(IBAction)man:(id)sender;
-(IBAction)woman:(id)sender;

@end
