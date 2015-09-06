//
//  FirstCellCollectionViewCell.m
//  FadeInOutTest
//
//  Created by LXJ on 15/8/24.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import "FirstCellCollectionViewCell.h"

@implementation FirstCellCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)nextPageClick:(UIButton *)sender {
    if (self.firstToSecondBlock) {
        self.firstToSecondBlock();
    }
}

@end
