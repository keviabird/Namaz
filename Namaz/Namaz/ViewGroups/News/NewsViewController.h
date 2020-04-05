//
//  NewsViewController.h
//  Namaz
//
//  Created by Elena Gracheva on 07.06.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UIImageView *mainBackground;
@property(nonatomic,weak) IBOutlet UITableView *table;

@property(nonatomic) UIRefreshControl *refreshControl;

-(IBAction)back:(id)sender;

@end
