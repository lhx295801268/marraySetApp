//
//  YCSecondCell.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/27.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCSecondCell.h"
#import "PureLayout.h"

@implementation YCSecondCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.tipsLabel = [UILabel newAutoLayoutView];
        self.tipsLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.tipsLabel];
        [self.tipsLabel autoSetDimension:ALDimensionWidth toSize:200];
        [self.tipsLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.tipsLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.showLabel = [UILabel newAutoLayoutView];
        self.showLabel.textColor = [UIColor purpleColor];
        [self.contentView addSubview:self.showLabel];
        [self.showLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.tipsLabel];
        [self.showLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.tipsLabel withOffset:10];
        [self.showLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
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
