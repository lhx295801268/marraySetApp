//
//  YCSecondCtrl.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/25.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCSecondCtrl.h"
#import "YCSecondCell.h"
#import "YCConclusionObj.h"
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
    self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    self.dataList = [[NSMutableArray alloc] init];
    [self initUI];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadTitleView];
    [self.tableView reloadData];
}
- (void)reloadTitleView{
    YCConclusionObj *obj = [YCConclusionObj shareIns];
    CGFloat totalPrice = obj.hotelPrice + obj.weddingPrice + obj.weddingPicCompanyPrice + (obj.deskPrice * obj.deskCount);
    self.priceLabel.text = [NSString stringWithFormat:@"%@", @(totalPrice)];
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
    [priceLable autoSetDimension:ALDimensionWidth toSize:100];
    
    UIButton *refreshBtn = [UIButton newAutoLayoutView];
    [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    refreshBtn.layer.cornerRadius = 5;
    refreshBtn.layer.borderWidth = 1;
    refreshBtn.layer.borderColor = [UIColor blackColor].CGColor;
    refreshBtn.layer.masksToBounds = YES;
    [refreshBtn addTarget:self action:@selector(clickRefreshBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [titleContentView addSubview:refreshBtn];
    [refreshBtn autoSetDimension:ALDimensionHeight toSize:50];
    [refreshBtn autoSetDimension:ALDimensionWidth toSize:70];
    [refreshBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [refreshBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    
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

- (void)clickRefreshBtnMethod{
    [self reloadTitleView];
    [self.tableView reloadData];
}

- (void)initData{
    self.dataList = [@[@"要求来宾数：", @"来宾人数：", @"酒店名称：", @"酒店桌位数量：", @"酒店每个桌位价格：", @"酒店价格：", @"婚庆公司名：", @"婚庆公司价格：：", @"婚纱照公司名：", @"婚纱照公司价格："] mutableCopy];
    [self.tableView reloadData];
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
        @weakify(self);
        cell.refreshUIBlock = ^(id  _Nullable param) {
            [self_weak_ reloadTitleView];
            [self_weak_.tableView reloadData];
        };
    }
    cell.tipsLabel.text = [self.dataList objectAtIndex:indexPath.row];
    YCConclusionObj *obj = [YCConclusionObj shareIns];
    cell.indexPath = indexPath;
    cell.showTextView.editable = YES;
    switch (indexPath.row) {
        case 0:
        {
            cell.showTextView.text = [NSString stringWithFormat:@"%@", @(obj.inviteCount)];
            cell.showTextView.editable = NO;
        }
            break;
        case 1:
        {
            cell.showTextView.text = [NSString stringWithFormat:@"%@", @(obj.totalCount)];
            cell.showTextView.editable = NO;
        }
            break;
        case 2:
        {
            cell.showTextView.text = obj.hotelName;
        }
            break;
        case 3:
        {
            cell.showTextView.text = [NSString stringWithFormat:@"%@", @(obj.deskCount)];
        }
            break;
        case 4:
        {
            cell.showTextView.text = cell.showTextView.text = [NSString stringWithFormat:@"%@", @(obj.deskPrice)];
        }
            break;
        case 5:
        {
            cell.showTextView.editable = NO;
            obj.hotelPrice = obj.deskCount * obj.deskPrice;
            cell.showTextView.text = cell.showTextView.text = [NSString stringWithFormat:@"%@", @(obj.hotelPrice)];
        }
            break;
        case 6:
        {
            cell.showTextView.text = obj.weddingCompanyName;
        }
            break;
        case 7:
        {
            cell.showTextView.text = [NSString stringWithFormat:@"%@", @(obj.weddingPrice)];
        }
            break;
        case 8:
        {
            cell.showTextView.text = obj.weddingPicCompanyName;
        }
            break;
        case 9:
        {
            cell.showTextView.text = [NSString stringWithFormat:@"%@", @(obj.weddingPicCompanyPrice)];
        }
            break;
        default:
            break;
    }
    return cell;
}
@end
