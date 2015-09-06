//
//  FirstCellCollectionViewCell.h
//  FadeInOutTest
//
//  Created by LXJ on 15/8/24.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstCellCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic, copy) void(^firstToSecondBlock)(void);

@end
