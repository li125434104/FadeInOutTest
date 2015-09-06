//
//  SecondCollectionViewCell.m
//  FadeInOutTest
//
//  Created by LXJ on 15/8/24.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import "SecondCollectionViewCell.h"

@implementation SecondCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)prePageClick:(UIButton *)sender {
    if (self.secondBackFirst) {
        self.secondBackFirst();
    }
}

- (IBAction)nextPageClick:(UIButton *)sender {
    if (self.secondToThird) {
        self.secondToThird();
    }
}


@end
