//
//  YCTableBarCtrl.h
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/25.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface BarBtnItemContentView : UIView
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSArray<UIImage *> *imageList;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UILabel *bottomTitleLabel;
- (void)setImageList:(NSArray<UIImage *> * _Nonnull)imageList;
@end

@interface YCTableBarCtrl : UITabBarController

@end

NS_ASSUME_NONNULL_END
