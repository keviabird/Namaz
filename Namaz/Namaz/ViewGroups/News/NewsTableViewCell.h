//
//  NewsTableViewCell.h
//  Namaz
//
//  Created by Elena Gracheva on 08.06.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIImageView *image;
@property(nonatomic,weak) IBOutlet UILabel *title;
@property(nonatomic,weak) IBOutlet UILabel *date;

@end
