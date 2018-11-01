//
//  YCMainCtrl.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/25.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCMainCtrl.h"
#import "YCFileManager.h"
#import "YCPathConfig.h"
#import "YCMainCell.h"
#import "YCConclusionObj.h"
#import "YCHttpRequest.h"
#import "addFamilyCtrl/YCAddFamilyCtrlViewController.h"

#import "DataModel.h"
#import "ItemFamilyTb.h"
@interface YCMainCtrl()<UITableViewDelegate, UITableViewDataSource, DataModelFamilyChangeDelegate>
@property (nonatomic, strong) UIView *titleContentView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger clickTimes;
@property (nonatomic, strong) DataModel *dataModel;
@end
@implementation YCMainCtrl
- (instancetype)initWithFlowName:(NSString *)flowName{
    if(self = [super initWithFlowName:flowName]){
        self.navationbarHidden = YES;
        
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    self.dataList = [[NSMutableArray alloc] init];
    self.dataModel = [DataModel shareIns];
    self.dataModel.delegate = self;
    [self initUI];
    [self initData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.dataModel refreshData];
}

- (void)initUI{
    self.titleContentView  = [UIView newAutoLayoutView];
    [self.view addSubview:self.titleContentView];
    self.titleContentView.backgroundColor = [UIColor grayColor];
    [self.titleContentView autoSetDimension:ALDimensionHeight toSize:49];
    [self.titleContentView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.titleContentView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.titleContentView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    self.addBtn = [UIButton newAutoLayoutView];
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    self.addBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.addBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.addBtn.layer.cornerRadius = 5;
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.borderWidth = 1;
    [self.addBtn addTarget:self action:@selector(clickAddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:self.addBtn];
    [self.addBtn autoSetDimension:ALDimensionHeight toSize:40];
    [self.addBtn autoSetDimension:ALDimensionWidth toSize:60];
    [self.addBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.addBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    
    self.tableView = [UITableView newAutoLayoutView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleContentView];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)clickAddBtnAction:(UIButton *)actionBtn{
    YCAddFamilyCtrlViewController *ctrl = [[YCAddFamilyCtrlViewController alloc] initWithFlowName:@""];
    [self gotoNextCtrl:ctrl];
}

- (void)initData{
    self.dataList = [[self.dataModel getFamilyDataList] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YCMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[YCMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.nameLabel.text = @"";
    cell.countLabel.text = @"";
    ItemFamilyTb *obj = [self.dataList objectAtIndex:indexPath.row];
    cell.nameLabel.text = obj.familyName;
    cell.countLabel.text = [NSString stringWithFormat:@"%@", @(obj.memberCount)];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemFamilyTb *obj = [self.dataList objectAtIndex:indexPath.row];
    [self.dataModel deleteItemFamily:obj];
}

#pragma mark DataModelFamilyChangeDelegate
-(void)addItemFamily:(ItemFamilyTb *)addedFamily{
    self.dataList = [[self.dataModel getFamilyDataList] mutableCopy];
    [self mainThreadReloadView];
}

- (void)deleteItemFamily:(ItemFamilyTb *)dFamily{
    self.dataList = [[self.dataModel getFamilyDataList] mutableCopy];
    [self mainThreadReloadView];
}

- (void)familyListdidChange:(NSArray *)dataList{
    self.dataList = [dataList mutableCopy];
    [self mainThreadReloadView];
}

- (void)updateItemFamily:(ItemFamilyTb *)updatedFamily {
    
}

- (void)mainThreadReloadView{
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self_weak_.tableView reloadData];
    });
}
@end
