//
//  TutorialTableViewController.h
//  Namaz
//
//  Created by Elena Gracheva on 18.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UIImageView *mainBackground;
@property(nonatomic,weak) IBOutlet UITableView *tableView;

-(IBAction)back:(id)sender;

@end
