//
//  YCSecondCell.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/27.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCSecondCell.h"
#import "PureLayout.h"
#import "YCConclusionObj.h"
@implementation YCSecondCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.tipsLabel = [UILabel newAutoLayoutView];
        self.tipsLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.tipsLabel];
        [self.tipsLabel autoSetDimension:ALDimensionWidth toSize:200];
        [self.tipsLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.tipsLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.showTextView = [UITextView newAutoLayoutView];
        self.showTextView.textColor = [UIColor purpleColor];
        [self.contentView addSubview:self.showTextView];
        [self.showTextView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.tipsLabel];
        [self.showTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.tipsLabel withOffset:10];
        [self.showTextView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.showTextView autoSetDimension:ALDimensionHeight toSize:40];
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
#pragma mark UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString *tempStr = textView.text;
    YCConclusionObj *obj = [YCConclusionObj shareIns];
    switch (self.indexPath.row) {
        case 2:
        {
            obj.hotelName = self.showTextView.text;
        }
            break;
        case 3:
        {
            obj.deskCount = [tempStr integerValue];
        }
            break;
        case 4:
        {
            obj.deskPrice = [tempStr floatValue];
        }
            break;
        case 5:
        {
            obj.hotelPrice = obj.deskCount * obj.deskPrice;
        }
            break;
        case 6:
        {
            obj.weddingCompanyName = tempStr;
        }
            break;
        case 7:
        {
            obj.weddingPrice = [tempStr floatValue];
        }
            break;
        case 8:
        {
            obj.weddingPicCompanyName = tempStr;
        }
            break;
        case 9:
        {
            obj.weddingPicCompanyPrice = [tempStr floatValue];
        }
            break;
        default:
            break;
    }
    [obj saveAttr];
    if (nil != self.refreshUIBlock) {
        self.refreshUIBlock(obj);
    }
}
@end
