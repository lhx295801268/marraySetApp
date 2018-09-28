//
//  YCSecondCell.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/27.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSysCtrl.h"
NS_ASSUME_NONNULL_BEGIN

@interface YCSecondCell : UITableViewCell <UITextViewDelegate>
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UITextView *showTextView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) ONE_PARAM_BLOCK refreshUIBlock;
@property (nonatomic, copy) TWO_PARAM_BLOCK textViewBecomeFirstBlock;
@end

NS_ASSUME_NONNULL_END
