//
//  YCAddFamilyCtrlViewController.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/26.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCAddFamilyCtrlViewController.h"
#import "ItemFamilyTb.h"
#import "DataModel.h"
@interface YCAddFamilyCtrlViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *countTextField;
@end

@implementation YCAddFamilyCtrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

-(void)initUI{
    UIView *contentView = [UIView newAutoLayoutView];
    contentView.layer.borderColor = [UIColor blackColor].CGColor;
    contentView.layer.borderWidth = 1;
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    [self.view addSubview:contentView];
    [contentView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [contentView autoSetDimension:ALDimensionHeight toSize:YCDefScreenHeight / 3];
    
    UITextField *textField = [UITextField newAutoLayoutView];
    textField.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    textField.placeholder = @"邀请对象名字";
    textField.textColor = [UIColor blackColor];
    [contentView addSubview:textField];
    [textField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [textField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [textField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [textField autoSetDimension:ALDimensionHeight toSize:50];
    
    UILabel *tipsLabel2 = [UILabel newAutoLayoutView];
    tipsLabel2.font = [UIFont systemFontOfSize:10];
    tipsLabel2.textColor = [UIColor grayColor];
    tipsLabel2.text = @"邀请对象家一共多少人";
    [contentView addSubview:tipsLabel2];
    [tipsLabel2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:textField withOffset:10];
    [tipsLabel2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:textField];
    
    UITextField *countTextField = [UITextField newAutoLayoutView];
    countTextField.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    countTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    countTextField.textColor = [UIColor purpleColor];
    countTextField.layer.cornerRadius = 2;
    [contentView addSubview:countTextField];
    [countTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tipsLabel2 withOffset:5];
    [countTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:tipsLabel2];
    [countTextField autoSetDimension:ALDimensionWidth toSize:60];
    [countTextField autoSetDimension:ALDimensionHeight toSize:50];
    
    UIButton *okBtn = [UIButton newAutoLayoutView];
    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
    okBtn.layer.cornerRadius = 5;
    [okBtn setBackgroundColor:[UIColor grayColor]];
    [okBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(clickOkBtn) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:okBtn];
    [okBtn autoSetDimension:ALDimensionWidth toSize:70];
    [okBtn autoSetDimension:ALDimensionHeight toSize:50];
    [okBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    self.textField = textField;
    self.countTextField = countTextField;
}

- (void)clickOkBtn{
    NSString *nameStr = self.textField.text;
    NSString *countStr = self.countTextField.text;
    nameStr = [nameStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    countStr = [countStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (nameStr.length <= 0) {
        [self showAlertView:@"" bodyStr:@"请填写被邀请人姓名，人数不填默认1个" clickBlock:nil];
        return;
    }
    NSInteger count = [countStr integerValue];
    count = (count <= 0) ? (1) : (count);
    ItemFamilyTb *tempObj = [[ItemFamilyTb alloc] init];
    tempObj.memberCount = count;
    tempObj.familyName = nameStr;
    [[DataModel shareIns] addItemFamily:tempObj];
    [self onBack];
}

@end
