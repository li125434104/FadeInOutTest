//
//  UIImage+BoxBlur.h
//  FadeInOutTest
//
//  Created by LXJ on 15/9/1.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BoxBlur)

- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur;

- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur withTintColor:(UIColor*)tintColor;

@end
