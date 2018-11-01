//
//  DBBase.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/10/31.
//  Copyright © 2018 TsunamiLi. All rights reserved.
//

#import "DBBase.h"
#import "YCPathConfig.h"
#import "YCFileManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
static FMDatabase *dataBase;
@interface DBBase()
@end

@implementation DBBase
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithResultSet:(FMResultSet *)resultSet{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
    }
    return self;
}
#pragma class method
+(FMDatabase *)dataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [FMDatabase databaseWithPath:[[YCFileManager getDBFolderPath] stringByAppendingPathComponent:NSStringFromClass([DBBase class])]];
    });
    return dataBase;
}

+ (void)openDB{
    if ([self dataBase].isOpen) {
        return;
    }
    if (![[self dataBase] open]) {
        NSLog(@"Open DataBase Error!!!!!");
    }
}

+ (void)closeDB{
    [[self dataBase] close];
}

+ (void)createTb{
    NSArray *columnList = [self columnsAttr];
    if (nil == columnList || columnList.count <= 0) {
        return;
    }
    [self openDB];
    NSString *columnStr = nil;
    for (NSArray *tempList in columnList) {
        if (nil == columnStr) {
            columnStr = [NSString stringWithFormat:@"%@ %@ DEFAULT %@", [tempList firstObject], [tempList objectAtIndex:1], [tempList lastObject]];
        }else{
            columnStr = [columnStr stringByAppendingString:[NSString stringWithFormat:@", %@ %@ DEFAULT %@", [tempList firstObject], [tempList objectAtIndex:1], [tempList lastObject]]];
        }
    }
    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@)", NSStringFromClass([self class]), columnStr];
    @weakify(self);
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self_weak_.dataBase executeUpdate:sqlStr];
        [self_weak_ closeDB];
    });
}
+(NSString *)tbName{
    return NSStringFromClass([self class]);
}

+ (NSArray *)columnsAttr{
    return nil;
}

+ (void)queryWithWhereStr:(NSString *)whereStr sucBlock:(SucBlockHandle)sucBlock failedBlock:(FailedBlockHandle)failedBlock{
    NSString *sqlStr = nil;
    if (nil == whereStr) {
        sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@", [self tbName]];
    }else{
        sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", [self tbName], whereStr];
    }
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self_weak_ openDB];
        FMResultSet *resultSet = [self_weak_.dataBase executeQuery:sqlStr];
        
        if (nil == resultSet) {
            NSLog(@"查询数据失败");
            if (failedBlock) {
                failedBlock(nil);
            }
            return;
        }
        
        NSMutableArray *resultList = [[NSMutableArray alloc] init];
        while ([resultSet next]) {
            NSArray *attrsList = [self_weak_ columnsAttr];
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
            for (NSArray *tempList in attrsList) {
                NSString *keyStr = [tempList firstObject];
                id tempValue = [resultSet objectForColumn:keyStr];
                [tempDic setObject:tempValue forKey:keyStr];
            }
            [resultList addObject:tempDic];
        }
        
        if (nil != sucBlock) {
            sucBlock(resultList);
        }
        [self_weak_ closeDB];
    });
}

+ (void)insert2Tb:(DBBase *)insertObj sucBlock:(SucBlockHandle)sucBlock failedBlock:(FailedBlockHandle)failedBlock{
    if (nil == insertObj) {
        if(nil != failedBlock){
            failedBlock(nil);
        }
        return;
    }
    NSArray *columnList = [self columnsAttr];
    NSString *columSqlStr = nil;
    NSString *valueSqlStr = nil;
    for (NSArray *itemList in columnList) {
        NSString *attrName = [itemList firstObject];
        NSString *typeStr = [itemList objectAtIndex:1];
        NSString *itemValueStr = [self attr2DbValue:[insertObj valueForKey:attrName] dbType:typeStr];
        if (nil == columSqlStr) {
            columSqlStr = attrName;
            valueSqlStr = itemValueStr;
        }else{
            columSqlStr = [columSqlStr stringByAppendingString:[NSString stringWithFormat:@", %@", attrName]];
            valueSqlStr = [valueSqlStr stringByAppendingString:[NSString stringWithFormat:@", %@", itemValueStr]];
        }
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@)", [self tbName], columSqlStr, valueSqlStr];
    NSLog(@"插入数据======>%@", columSqlStr);
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self_weak_ openDB];
        BOOL resultSet = [self_weak_.dataBase executeUpdate:sqlStr];
        [self_weak_ closeDB];
        if(!resultSet){
            NSLog(@"插入数据失败");
            if (nil != failedBlock) {
                failedBlock(nil);
            }
        }else if(nil != sucBlock){
            sucBlock(nil);
        }
        
    });
}

+ (void)delete2Tb:(NSString *)whereStr sucBlock:(SucBlockHandle)sucBlock failedBlock:(FailedBlockHandle)failedBlock{
    NSString *sqlStr = nil;
    if (nil == whereStr) {
        if (nil != failedBlock) {
            failedBlock(nil);
        }
        return;
    }
    sqlStr = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", [self tbName], whereStr];
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self_weak_ openDB];
        BOOL resultSet = [self_weak_.dataBase executeUpdate:sqlStr];
        [self_weak_ closeDB];
        if(!resultSet){
            NSLog(@"删除数据失败");
            if (nil != failedBlock) {
                failedBlock();
            }
        }else if(nil != sucBlock){
            sucBlock(nil);
        }
    });
}

+ (void)update2Tb:(NSString *)whereStr updateObj:(DBBase *)updateObj sucBlock:(SucBlockHandle)sucBlock failedBlock:(FailedBlockHandle)failedBlock{
    if (whereStr == nil) {
        if (nil != failedBlock) {
            failedBlock(nil);
        }
        return;
    }
    NSArray *columnList = [self columnsAttr];
    NSString *valueStr = nil;
    for (NSArray *itemList in columnList) {
        NSString *attrName = [itemList firstObject];
        NSString *typeStr = [itemList objectAtIndex:1];
        NSString *itemValueStr = [self attr2DbValue:[updateObj valueForKey:attrName] dbType:typeStr];
        if (nil == valueStr) {
            valueStr = [NSString stringWithFormat:@"%@=%@", attrName, itemValueStr];
        }else{
            valueStr = [valueStr stringByAppendingString:[NSString stringWithFormat:@", %@=%@", attrName, itemValueStr]];
        }
    }
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ SET (%@) WHERE %@", [self tbName], valueStr, whereStr];
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self_weak_ openDB];
        BOOL result = [self_weak_.dataBase executeUpdate:sqlStr];
        
        if(!result){
            NSLog(@"更新数据失败");
            if (nil != failedBlock) {
                failedBlock(nil);
            }
        }else if(nil != sucBlock){
            sucBlock(nil);
        }
        [self_weak_ closeDB];
    });
}

+ (NSString *)attr2DbValue:(id)attr dbType:(NSString *)dbType{
    if (nil == attr) {
        return nil;
    }
    if (nil == dbType) {
        return [NSString stringWithFormat:@"'%@'", attr];
    }
    if ([dbType isEqualToString:@"TEXT"]) {
        return [NSString stringWithFormat:@"'%@'",attr];
    }else {
        return [NSString stringWithFormat:@"%@", attr];
    }
}
@end
