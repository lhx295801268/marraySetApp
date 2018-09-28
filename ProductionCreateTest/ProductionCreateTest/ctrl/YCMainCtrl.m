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
#import "YCFamilyObj.h"
#import "YCListObj.h"
#import "YCMainCell.h"
#import "YCConclusionObj.h"
#import "addFamilyCtrl/YCAddFamilyCtrlViewController.h"
@interface YCMainCtrl()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *titleContentView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
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
    [self initUI];
    [self initData];
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
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleContentView];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)clickAddBtnAction:(UIButton *)actionBtn{
    YCAddFamilyCtrlViewController *ctrl = [[YCAddFamilyCtrlViewController alloc] initWithFlowName:@""];
    @weakify(self);
    ctrl.okBlock = ^(id param) {
        if (nil == param) {
            return;
        }
        if (nil == self.dataList) {
            self.dataList = [[NSMutableArray alloc] init];
        }
        [self_weak_.dataList addObject:param];
        [self_weak_.tableView reloadData];
        [YCConclusionObj shareIns].inviteCount ++;
        [YCConclusionObj shareIns].totalCount += ((YCFamilyObj *)param).membersCount;
        YCListObj *tempObj = [[YCListObj alloc] init];
        tempObj.familyObjList = self.dataList;
        NSString *saveStr = [tempObj yy_modelToJSONString];//[willSaveJsonList yy_modelToJSONString];
        NSString *path = [[YCFileManager getDocumentFolderPath] stringByAppendingPathComponent:YCDefFamilyObjFilePath];
        [YCFileManager writeDataToFile:saveStr path:path];
    };
    [self gotoNextCtrl:ctrl];
}

- (void)initData{
    NSString *path = [[YCFileManager getDocumentFolderPath] stringByAppendingPathComponent:YCDefFamilyObjFilePath];
    NSData *data = [YCFileManager readFileData4FilePath:path];
    if (nil == data) {
        return;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    YCListObj *tempObj = [YCListObj yy_modelWithJSON:jsonStr];
    tempObj.familyObjList = [NSArray yy_modelArrayWithClass:YCFamilyObj.class json:tempObj.familyObjList];
    if (nil != tempObj.familyObjList) {
        self.dataList = [tempObj.familyObjList mutableCopy];
        [self.tableView reloadData];
    }
    [YCConclusionObj shareIns].inviteCount = self.dataList.count;
    [YCConclusionObj shareIns].totalCount = [self statisticTotalCount];
}

/**
 统计总人数

 @return 返回总人数
 */
- (NSInteger)statisticTotalCount{
    NSInteger totalCount = 0;
    for (YCFamilyObj *obj in self.dataList) {
        totalCount += obj.membersCount;
    }
    return totalCount;
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
    YCFamilyObj *obj = [self.dataList objectAtIndex:indexPath.row];
    cell.nameLabel.text = obj.familyName;
    cell.countLabel.text = [NSString stringWithFormat:@"%@", @(obj.membersCount)];
    return cell;
}
@end
