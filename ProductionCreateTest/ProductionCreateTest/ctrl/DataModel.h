//
//  DataModel.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/10/31.
//  Copyright © 2018 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCConclusionObj;
@class ItemFamilyTb;
//总统计发生变动t通知
#define DefConclusionChangeNotification     @"DefConclusionChangeNotification"
/**
 家庭的数据部分发生变化的代理部分
 */
@protocol DataModelFamilyChangeDelegate <NSObject>

/**
 添加一个家庭

 @param addedFamily 添加的家庭对象
 */
- (void)addItemFamily:(ItemFamilyTb *)addedFamily;

/**
 删除一个家庭

 @param dFamily 删除的家庭对象
 */
- (void)deleteItemFamily:(ItemFamilyTb *)dFamily;

/**
 有一个家庭更新了数据

 @param updatedFamily 更新的家庭对象
 */
- (void)updateItemFamily:(ItemFamilyTb *)updatedFamily;

- (void)familyListdidChange:(NSArray *)dataList;
@end

/**
 家庭逻辑数据部分
 */
@interface DataModel : NSObject

/**
 总体对象
 */
@property (nonatomic, strong, readonly) YCConclusionObj *conclusionObj;
@property (nonatomic, weak) id<DataModelFamilyChangeDelegate> delegate;
+(instancetype)shareIns;

- (void)deleteItemFamily:(ItemFamilyTb *)srcFamily;

- (void)addItemFamily:(ItemFamilyTb *)srcObj;

- (NSArray*)getFamilyDataList;

- (void)refreshData;
@end
