//
//  YCSecondCtrl.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/25.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCSecondCtrl.h"
#import "YCSecondCell.h"
@interface YCSecondCtrl ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation YCSecondCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navationbarHidden = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    self.dataList = [[NSMutableArray alloc] init];
    [self initUI];
    [self initData];
}
- (void)initUI{
    UIView *titleContentView = [UIView newAutoLayoutView];
    [self.view addSubview:titleContentView];
    [titleContentView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [titleContentView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [titleContentView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [titleContentView autoSetDimension:ALDimensionHeight toSize:80];
    
    UILabel *tipsLabel = [UILabel newAutoLayoutView];
    tipsLabel.font = [UIFont systemFontOfSize:20];
    tipsLabel.text = @"总花费：";
    [titleContentView addSubview:tipsLabel];
    [tipsLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [tipsLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    
    UILabel *priceLable = [UILabel newAutoLayoutView];
    _priceLabel = priceLable;
    priceLable.textColor = [UIColor redColor];
    priceLable.font = [UIFont systemFontOfSize:15];
    [titleContentView addSubview:priceLable];
    [priceLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tipsLabel withOffset:10];
    [priceLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UIView *lineView = [UIView newAutoLayoutView];
    lineView.backgroundColor = [UIColor grayColor];
    [titleContentView addSubview:lineView];
    [lineView autoSetDimension:ALDimensionHeight toSize:1];
    [lineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    
    UITableView *tableView = [UITableView newAutoLayoutView];
    [self.view addSubview:tableView];
    [tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleContentView];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (void)initData{
    self.dataList = [@[@"被邀请者数量：", @"邀请总人数：", @"酒店位置：", @"桌数", @"每桌价格：", @"总价", @"婚庆公司：", @"婚庆公司价格：", @"婚纱照公司：", @"婚纱照价格："] mutableCopy];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YCSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[YCSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tipsLabel.text = [self.dataList objectAtIndex:indexPath.row];
    return cell;
}
@end
