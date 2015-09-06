//
//  SecondCollectionViewCell.h
//  FadeInOutTest
//
//  Created by LXJ on 15/8/24.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) void(^secondBackFirst)(void);
@property (nonatomic, copy) void(^secondToThird)(void);
@end
