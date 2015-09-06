//
//  CoreAnimationEffect.h
//  FadeInOutTest
//
//  Created by LXJ on 15/8/21.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CoreAnimationEffect : NSObject
//*   @param type                动画过渡类型
//*   @param subType             动画过渡方向(子类型)
//*   @param duration            动画持续时间
//*   @param timingFunction      动画定时函数属性
//*   @param theView             需要添加动画的view.

@property (strong, nonatomic) CABasicAnimation *contentsAnimation;
@property (strong, nonatomic) UIImageView *imageViews;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (assign, nonatomic) int i;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) BOOL isBlur;

+ (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                     view:(UIView *)theView;

/**
 *  渐隐渐出
 */
+ (void)animationEaseIn:(UIView *)view;
+ (void)animationEaseOut:(UIView *)view;

/**
 *  自己写的循环渐隐渐现
 */
- (void)showFadeInOutImages:(NSArray *)images
                   duration:(CFTimeInterval)duration
                       view:(UIImageView *)imageView
                       blur:(BOOL)isBlur;
@end
