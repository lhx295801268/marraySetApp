//
//  YCTableBarCtrl.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/25.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCTableBarCtrl.h"
#import "YCSysCtrl.h"
#import "YCMainCtrl.h"
#import "YCSecondCtrl.h"
#import "UIImageView+WebCache.h"
@implementation BarBtnItemContentView

- (instancetype)init {
    if(self = [super init]){
         self.isSelected = NO;
        [self initUI];
        [self bindRac];
//        [self bindEvent];
    }
    return self;
}

- (void)initUI {
    UIView *contentView = [UIView newAutoLayoutView];
    [self addSubview:contentView];
    [contentView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    self.selectImageView = [UIImageView newAutoLayoutView];
    self.selectImageView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:self.selectImageView];
    [self.selectImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.selectImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    self.bottomTitleLabel = [UILabel newAutoLayoutView];
    self.bottomTitleLabel.text = @"bottomTitleLabel";
    self.bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.bottomTitleLabel];
    [self.bottomTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.selectImageView];
    [self.bottomTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.bottomTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.bottomTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)bindRac {
//    __weak BarBtnItemContentView *weakSelf = self;
    @weakify(self);
    [RACObserve(self, isSelected) subscribeNext:^(id  _Nullable x) {
        if(self_weak_.imageList == nil || self_weak_.imageList.count <= 0){
            return;
        }
        if (![x boolValue]) {
            UIImage *image = [self_weak_.imageList firstObject];
            [self_weak_.selectImageView setImage:image];
        }else{
            UIImage *image = [self_weak_.imageList firstObject];
            if(self_weak_.imageList.count >= 2){
                image = [self_weak_.imageList objectAtIndex:1];
            }
            [self_weak_.selectImageView setImage:image];
        }
    }];
}
- (void)setImageList:(NSArray<UIImage *> * _Nonnull)imageList{
    _imageList = imageList;
    self.isSelected = self.isSelected;
}
@end

@interface YCTableBarCtrl ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *barList;
@property(nonatomic, strong) NSArray<YCSysCtrl *> *ctrlList;
@end

@implementation YCTableBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.barList = @[@[@"Main", @[@"", @""]], @[@"second", @[@"", @""]]].mutableCopy;
    self.ctrlList = @[[[YCMainCtrl alloc] initWithFlowName:@"YCMainCtrl"],
                      [[YCSecondCtrl alloc] initWithFlowName:@"YCSecondCtrl"]];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (YCSysCtrl *tempCtrl in self.ctrlList) {
        [tempCtrl setNavCtrl:(UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController];
    }
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    for (NSInteger pos = 0; pos < self.barList.count; pos++) {
        NSArray *tempList = [self.barList objectAtIndex:pos];
        if (nil == tempList || tempList.count <= 0) {
            continue;
        }
        NSString *tempNameStr = [tempList firstObject];
        YCSysCtrl *tempCtrl = [self.ctrlList objectAtIndex:pos];
        tempCtrl.title = tempNameStr;
        tempCtrl.tabBarItem.title = tempNameStr;
//        [tempCtrl.tabBarItem setTitleTextAttributes:nil forState:UIControlStateSelected];
        tempCtrl.view.tag = pos;
        [tempCtrl setNavCtrl:self.navigationController];
        [self addChildViewController:tempCtrl];
    }
}
#pragma mark UITabBarControllerDelegate
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0);
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}
//
//- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed __TVOS_PROHIBITED;
//
//- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
//- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0);
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
//                                                       toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);

@end
