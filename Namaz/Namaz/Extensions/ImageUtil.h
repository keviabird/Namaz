//
//  UIImage+Resize.h
//  Namaz
//
//  Created by Elena Gracheva on 02.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageUtil : UIImage

+(UIImage *)resizedImageNamed:(NSString *)name ;
+(void)bluredImage:(UIImageView *)input;

@end
