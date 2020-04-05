//
//  UIImage+Resize.m
//  Namaz
//
//  Created by Elena Gracheva on 02.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "ImageUtil.h"
#import "UIImage+ImageEffects.h"

@implementation ImageUtil

+(UIImage *)resizedImageNamed:(NSString *)name {
    if ([UIScreen mainScreen].bounds.size.height == 667) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@-667h", name]];
    }
    return [UIImage imageNamed:name];
}

+(void)bluredImage:(UIImageView *)input {
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    
//    // add effect to an effect view
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effectView.frame = input.frame;
//    
//    // add the effect view to the image view
//    [input addSubview:effectView];
    
    input.image = [input.image applyBlurWithRadius:10. tintColor:nil saturationDeltaFactor:1. maskImage:nil];
    
        //Blur the UIImage with a CIFilter
//    return input;
//    CIImage *imageToBlur = [CIImage imageWithCGImage:input.CGImage];
//    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
//    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
//    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: 10] forKey: @"inputRadius"];
//    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
//    UIImage *result = [[UIImage alloc] initWithCIImage:resultImage];
//    return [result imageWithAlignmentRectInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
}

@end
