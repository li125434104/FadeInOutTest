//
//  CoreAnimationEffect.m
//  FadeInOutTest
//
//  Created by LXJ on 15/8/21.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import "CoreAnimationEffect.h"
#import "UIImage+BoxBlur.h"

@implementation CoreAnimationEffect

+ (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                     view:(UIView *)theView {
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animation.fillMode = kCAFillModeForwards;
    animation.type = type;
    animation.subtype = subType;
    [theView.layer addAnimation:animation forKey:nil];
}

+ (void)animationEaseIn:(UIView *)view {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationEaseOut:(UIView *)view {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}

/**
 *  自己写的渐隐渐现
 */
- (void)showFadeInOutImages:(NSArray *)images duration:(CFTimeInterval)duration view:(UIImageView *)imageView blur:(BOOL)isBlur{
    if (images.count==0) {
        return;
    }
    
    self.imageViews = imageView;
    self.images     = images;
    self.duration   = duration;
    _i = 1;
    _isBlur = isBlur;
    
    //给image加上blur效果
    if (isBlur) {
        self.imageArray = [NSMutableArray array];
        for (int i = 0; i < images.count; i++) {
            UIImage *blurImage= [[UIImage imageNamed:[NSString stringWithFormat:@"%@",images[i]]] drn_boxblurImageWithBlur:0.3];
            [self.imageArray addObject:blurImage];
        }
        
    }


    if (isBlur) {
        imageView.layer.contents = (__bridge id)((UIImage *)self.imageArray[0]).CGImage;
    } else {
        imageView.layer.contents = (__bridge id)([UIImage imageNamed:[NSString stringWithFormat:@"%@",images[0]]].CGImage);
    }
    
    _contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    
    [self performSelector:@selector(autoPlayToNextImage) withObject:nil afterDelay:duration * 2];
}

- (void)autoPlayToNextImage {
    
    _contentsAnimation.fromValue = self.imageViews.layer.contents;
    
    if (_isBlur) {
        _contentsAnimation.toValue = (__bridge id)((UIImage *)self.imageArray[_i]).CGImage;
    } else {
        _contentsAnimation.toValue = (__bridge id)([UIImage imageNamed:[NSString stringWithFormat:@"%@",self.images[_i]]].CGImage);
    }
    
    _contentsAnimation.duration = self.duration;
    
    if (_isBlur) {
        self.imageViews.layer.contents = (__bridge id)((UIImage *)self.imageArray[_i]).CGImage;
    } else {
        self.imageViews.layer.contents = (__bridge id)([UIImage imageNamed:[NSString stringWithFormat:@"%@",self.images[_i]]].CGImage);
    }
    
    [self.imageViews.layer addAnimation:_contentsAnimation forKey:nil];

    _i += 1;
    
    if (_i == self.images.count) {
        _i = 0;
    }
    
    [self performSelector:@selector(autoPlayToNextImage) withObject:nil afterDelay:self.duration * 2];
}

@end
