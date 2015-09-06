//
//  ViewController.m
//  FadeInOutTest
//
//  Created by LXJ on 15/8/21.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import "ViewController.h"
#import "CoreAnimationEffect.h"
#import "FirstCellCollectionViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ThirdCollectionViewCell.h"
#import "UIImage+BoxBlur.h"

static NSString *kFirstCellIdentifier = @"kFirstCellIdentifier";
static NSString *kSecondCellIdentifier = @"kSecondCellIdentifier";
static NSString *kThirdCellIdentifier = @"kThirdCellIdentifier";

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViews;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViews;
@property (weak, nonatomic) IBOutlet UIView *animationView;

@property (strong, nonatomic) CABasicAnimation *contentsAnimation;
@property (assign, nonatomic) int i;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *ima1 = [UIImage imageNamed:@"Image1"];
//    UIImage *ima2 = [UIImage imageNamed:@"Image2"];
//    UIImage *ima3 = [UIImage imageNamed:@"Image3"];
//    
//    self.imageViews.animationImages = [NSArray arrayWithObjects:ima1, ima2, ima3, nil];
//    self.imageViews.animationDuration = 5.f;
//    [self.imageViews startAnimating];

//    [self setImages];
    
    //封装的渐隐渐现
    NSArray *images = @[@"Image1", @"Image2", @"Image3"];
    CoreAnimationEffect *animation = [[CoreAnimationEffect alloc] init];
    [animation showFadeInOutImages:images duration:3.f view:self.imageViews blur:YES];
    
    [self registerCell];
    
    //系统自带模糊
//    [self setBackBlur];
}

- (void)setImages {
    
    _i = 1;
    
    self.imageViews.layer.contents = (__bridge id)([UIImage imageNamed:[NSString stringWithFormat:@"Image%d",_i]].CGImage);
    
    _contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
  
    [self performSelector:@selector(autoPlayToNextImage) withObject:nil afterDelay:6.f];
}

- (void)autoPlayToNextImage {
    _contentsAnimation.fromValue = self.imageViews.layer.contents;
    _contentsAnimation.toValue = (__bridge id)([UIImage imageNamed:[NSString stringWithFormat:@"Image%d",_i+1]].CGImage);
    _contentsAnimation.duration = 3.f;
    self.imageViews.layer.contents = (__bridge id)([UIImage imageNamed:[NSString stringWithFormat:@"Image%d",_i+1]].CGImage);
    [self.imageViews.layer addAnimation:_contentsAnimation forKey:nil];

    _i += 1;
    
    if (_i == 3) {
        _i = 0;
    }

    [self performSelector:@selector(autoPlayToNextImage) withObject:nil afterDelay:9.f];
}

- (void)registerCell {
    [self.collectionViews registerNib:[UINib nibWithNibName:@"FirstCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kFirstCellIdentifier];
    [self.collectionViews registerNib:[UINib nibWithNibName:@"SecondCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kSecondCellIdentifier];
    [self.collectionViews registerNib:[UINib nibWithNibName:@"ThirdCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kThirdCellIdentifier];
}

#pragma mark
#pragma mark 自带api设置背景模糊
- (void)setBackBlur {
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_imageViews addSubview:visualEffectView];
}

#pragma mark
#pragma mark collectionView delegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 285);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            FirstCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFirstCellIdentifier forIndexPath:indexPath];
            cell.nameTextField.delegate = self;
            cell.firstToSecondBlock = ^() {
                [self setXOffSet:[UIScreen mainScreen].bounds.size.width];
            };
            return cell;
        }
            break;
        case 1:
        {
            SecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSecondCellIdentifier forIndexPath:indexPath];
            cell.secondBackFirst = ^() {
                [self setXOffSet:0];
            };
            cell.secondToThird = ^() {
                [self setXOffSet:2 * [UIScreen mainScreen].bounds.size.width];
            };
            return cell;
        }
            
            break;
        case 2:
        {
            ThirdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kThirdCellIdentifier forIndexPath:indexPath];
            cell.thirdBackSecond = ^() {
                [self setXOffSet:[UIScreen mainScreen].bounds.size.width];
            };
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark
#pragma mark 控制collection左右滑动
- (void)setXOffSet:(CGFloat)offset {
    [_collectionViews setContentOffset:CGPointMake(offset, 0) animated:YES];
}

//收起键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark
#pragma mark 键盘升起落下
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:.5f animations:^{
        self.collectionViews.frame = CGRectMake(0, self.collectionViews.frame.origin.y - 200, [UIScreen mainScreen].bounds.size.width, 285);
        self.animationView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.animationView.center = CGPointMake(self.animationView.center.x, 70);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:.5f animations:^{
        self.collectionViews.frame = CGRectMake(0, self.view.frame.size.height - 33 - 285, [UIScreen mainScreen].bounds.size.width, 285);
        self.animationView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.animationView.center = CGPointMake(self.animationView.center.x, 195);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
