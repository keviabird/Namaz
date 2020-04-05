//
//  CityTableViewController.h
//  Namaz
//
//  Created by Elena Gracheva on 17.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UIImageView *mainBackground;
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *activityIndicator;

-(IBAction)back:(id)sender;

@end
