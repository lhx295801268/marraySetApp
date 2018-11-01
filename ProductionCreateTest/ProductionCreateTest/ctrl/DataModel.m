//
//  DataModel.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/10/31.
//  Copyright © 2018 TsunamiLi. All rights reserved.
//

#import "DataModel.h"
#import "DBBase.h"
#import "ItemFamilyTb.h"
#import "ReactiveObjC.h"
#import "YCConclusionObj.h"
@interface DataModel()
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation DataModel
- (instancetype)init{
    if (self = [super init]) {
        self.dataList = [[NSMutableArray alloc] init];
        @weakify(self);
        [ItemFamilyTb createTb];
        [ItemFamilyTb queryWithWhereStr:nil sucBlock:^(NSArray*  _Nullable param) {
            if (nil == param) {
                return ;
            }
            for (NSDictionary *tempDic in param) {
                ItemFamilyTb *tempObj = [[ItemFamilyTb alloc] initWithDic:tempDic];
                [self.dataList addObject:tempObj];
            }
            if (self_weak_.delegate && ([self_weak_.delegate respondsToSelector:@selector(familyListdidChange:)])) {
                [self_weak_.delegate familyListdidChange:self_weak_.dataList];
            }
            [self_weak_ changeItemMethod];
        } failedBlock:nil];
    }
    return self;
}

+(instancetype)shareIns{
    static dispatch_once_t onceToken;
    static DataModel *model = nil;
    dispatch_once(&onceToken, ^{
        model = [[DataModel alloc] init];
    });
    return model;
}

- (void)deleteItemFamily:(ItemFamilyTb *)srcFamily{
    if (nil == srcFamily) {
        return;
    }
    @weakify(self);
    [ItemFamilyTb delete2Tb:[NSString stringWithFormat:@"familyName='%@'", srcFamily.familyName] sucBlock:^(NSArray *param) {
        //删除成功操作
        [self_weak_.dataList removeObject:srcFamily];
        self_weak_.conclusionObj.inviteCount--;
        [self_weak_.conclusionObj saveAttr];
        if (self_weak_.delegate && [self_weak_.delegate respondsToSelector:@selector(deleteItemFamily:)]) {
            [self_weak_.delegate deleteItemFamily:srcFamily];
        }
        [self_weak_ changeItemMethod];
    } failedBlock:nil];
}

- (void)addItemFamily:(ItemFamilyTb *)srcObj{
    if (nil == srcObj) {
        return;
    }
    @weakify(self);
    [ItemFamilyTb insert2Tb:srcObj sucBlock:^(NSArray *param) {
        [self_weak_.dataList addObject:srcObj];
        if (self_weak_.delegate && [self_weak_.delegate respondsToSelector:@selector(addItemFamily:)]) {
            [self_weak_.delegate addItemFamily:srcObj];
        }
        [self_weak_ changeItemMethod];
    } failedBlock:nil];
}

- (void)refreshData{
    [self.dataList removeAllObjects];
    @weakify(self);
    [ItemFamilyTb queryWithWhereStr:nil sucBlock:^(NSArray*  _Nullable param) {
        if (nil == param) {
            return ;
        }
        for (NSDictionary *tempDic in param) {
            ItemFamilyTb *tempObj = [[ItemFamilyTb alloc] initWithDic:tempDic];
            [self.dataList addObject:tempObj];
        }
        if (self_weak_.delegate && ([self_weak_.delegate respondsToSelector:@selector(familyListdidChange:)])) {
            [self_weak_.delegate familyListdidChange:self_weak_.dataList];
        }
        [self_weak_ changeItemMethod];
    } failedBlock:nil];
}

- (NSArray*)getFamilyDataList{
    return self.dataList;
}

- (void)changeItemMethod{
    [YCConclusionObj shareIns].inviteCount = self.dataList.count;
    NSInteger totalCount = 0;
    for (ItemFamilyTb *tempObj in self.dataList) {
        totalCount +=  tempObj.memberCount;
    }
    [YCConclusionObj shareIns].totalCount = totalCount;
    [YCConclusionObj shareIns].deskCount = (totalCount / 10) + ((totalCount%10 > 0) ? (1) : (0));
    [[YCConclusionObj shareIns] saveAttr];
    [self postNotification:DefConclusionChangeNotification];
}

- (void)postNotification:(NSString *)notificationName{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}
@end
