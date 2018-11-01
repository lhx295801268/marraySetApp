//
//  DBBase.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/10/31.
//  Copyright © 2018 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCTypeDefObj.h"
#import <FMDB/FMDB.h>
typedef void (^SucBlockHandle)(NSArray<NSDictionary *> *param);
typedef void (^FailedBlockHandle)();
@interface DBBase : NSObject

+(FMDatabase *)dataBase;

+ (void)openDB;

+ (void)closeDB;

+ (void)createTb;

+ (NSString *)attr2DbValue:(id)attr dbType:(NSString *)dbType;

/**
 查询

 @param whereStr 条件语句nil表示全查询
 @param sucBlock 成功回调 返回参数resultset
 @param failedBlock 失败回调
 */
+ (void)queryWithWhereStr:(NSString *)whereStr sucBlock:(SucBlockHandle)sucBlock failedBlock:(FailedBlockHandle)failedBlock;

+ (void)insert2Tb:(DBBase *)insertObj sucBlock:(SucBlockHandle)sucBlock failedBlock:(FailedBlockHandle)failedBlock;

+ (void)delete2Tb:(NSString *)whereStr sucBlock:(SucBlockHandle)sucBlock failedBlock:(FailedBlockHandle)failedBlock;

+ (void)update2Tb:(NSString *)whereStr updateObj:(DBBase *)updateObj sucBlock:(SucBlockHandle)sucBlock failedBlock:(FailedBlockHandle)failedBlock;

#pragma mark 子类需要实现
+(NSString *)tbName;

+ (NSArray *)columnsAttr;
/**
 根据数据库返回初始化数据

 @param resultSet 数据库返回对象
 @return self
 */
- (instancetype)initWithResultSet:(FMResultSet *)resultSet;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
