//
//  TutorialCellTableViewCell.h
//  Namaz
//
//  Created by Elena Gracheva on 06.04.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialTableViewCell : UITableViewCell

@property(weak) IBOutlet UILabel *nameLabel;
@property(nonatomic,weak) IBOutlet UIView *line;

@end
