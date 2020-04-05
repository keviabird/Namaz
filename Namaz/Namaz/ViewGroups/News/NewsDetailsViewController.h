//
//  NewsDetailsViewController.h
//  Namaz
//
//  Created by Elena Gracheva on 15.06.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface NewsDetailsViewController : UIViewController

@property(nonatomic) News *news;

@property(nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic,weak) IBOutlet UIImageView *picture;
@property(nonatomic,weak) IBOutlet UILabel *head;
@property(nonatomic,weak) IBOutlet UILabel *date;
@property(nonatomic,weak) IBOutlet UILabel *text;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *textHeightConstraint;

-(IBAction)back:(id)sender;

@end
