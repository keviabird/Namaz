//
//  GenderViewController.m
//  Namaz
//
//  Created by Elena Gracheva on 17.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import "GenderViewController.h"
#import "Schedule.h"
#import "TimerUtil.h"
#import "ImageUtil.h"
#import "DataUtil.h"
#import "Const.h"

@interface GenderViewController () {
    UIImage *manImage;
    UIImage *womanImage;
    UIImage *manPressedImage;
    UIImage *womanPressedImage;
}

@end

@implementation GenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manImage = [ImageUtil resizedImageNamed:@"Man"];
    womanImage = [ImageUtil resizedImageNamed:@"Woman"];
    manPressedImage = [ImageUtil resizedImageNamed:@"Man_pressed"];
    womanPressedImage = [ImageUtil resizedImageNamed:@"Woman_pressed"];
    
    [self.man setImage:manImage forState:UIControlStateNormal];
    [self.woman setImage:womanImage forState:UIControlStateNormal];
    [self.man setImage:manPressedImage forState:UIControlStateHighlighted];
    [self.woman setImage:womanPressedImage forState:UIControlStateHighlighted];
    self.manTitle.alpha = 0.5;
    self.womanTitle.alpha = 0.5;
    
    self.mainBackground.image = [ImageUtil resizedImageNamed:@"Gender"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setImages];
}

-(void)setImages {
    NSString *gender = [DataUtil getGender];
    
    if ([gender isEqualToString:NAMAZ_GENDER_MAN]) {
        [self.man setImage:manPressedImage forState:UIControlStateNormal];
        [self.woman setImage:womanImage forState:UIControlStateNormal];
        self.manTitle.alpha = 1.;
        self.womanTitle.alpha = 0.5;
    } else if ([gender isEqualToString:NAMAZ_GENDER_WOMAN]) {
        [self.man setImage:manImage forState:UIControlStateNormal];
        [self.woman setImage:womanPressedImage forState:UIControlStateNormal];
        self.manTitle.alpha = 0.5;
        self.womanTitle.alpha = 1.;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)man:(id)sender {
    [DataUtil setGender:NAMAZ_GENDER_MAN];
    [self setImages];
}

-(IBAction)woman:(id)sender {
    [DataUtil setGender:NAMAZ_GENDER_WOMAN];
    [self setImages];
}

@end
