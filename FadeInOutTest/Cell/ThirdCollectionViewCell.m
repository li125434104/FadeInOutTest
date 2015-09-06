//
//  ThirdCollectionViewCell.m
//  FadeInOutTest
//
//  Created by LXJ on 15/8/24.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import "ThirdCollectionViewCell.h"

@implementation ThirdCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)prePageClick:(UIButton *)sender {
    if (self.thirdBackSecond) {
        self.thirdBackSecond();
    }
}

@end
