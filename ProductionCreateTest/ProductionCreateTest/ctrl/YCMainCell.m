//
//  YCMainCell.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/27.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCMainCell.h"
#import "PureLayout.h"
@implementation YCMainCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UILabel *tipsOneLable = [UILabel newAutoLayoutView];
        UILabel *nameLabel = [UILabel newAutoLayoutView];
        UILabel *tipsTowLabel = [UILabel newAutoLayoutView];
        UILabel *countLabel = [UILabel newAutoLayoutView];
        _tipsOneLabel = tipsOneLable;
        _nameLabel = nameLabel;
        _tipsTowLabel = tipsTowLabel;
        _countLabel = countLabel;
        
        UIView *centerView = [UIView newAutoLayoutView];
        [self.contentView addSubview:centerView];
        [centerView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [centerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [centerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        tipsOneLable.textColor = [UIColor blackColor];
        tipsOneLable.text = @"被邀请人/家庭名称：";
        [centerView addSubview:tipsOneLable];
        [tipsOneLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [tipsOneLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        
        nameLabel.textColor = [UIColor purpleColor];
        [centerView addSubview:nameLabel];
        [nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tipsOneLable withOffset:5];
        [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [nameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:tipsOneLable];
        
        tipsTowLabel.textColor = [UIColor blackColor];
        tipsTowLabel.text = @"包含人数：";
        [centerView addSubview:tipsTowLabel];
        [tipsTowLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tipsOneLable withOffset:10];
        [tipsTowLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:tipsOneLable];
        [tipsTowLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        countLabel.textColor = [UIColor blueColor];
        [centerView addSubview:countLabel];
        [countLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:tipsTowLabel];
        [countLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:nameLabel];
        [countLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [tipsOneLable autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
            [tipsOneLable autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
