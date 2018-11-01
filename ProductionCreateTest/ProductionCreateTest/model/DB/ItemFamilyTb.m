//
//  ItemFamilyTb.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/10/31.
//  Copyright © 2018 TsunamiLi. All rights reserved.
//

#import "ItemFamilyTb.h"

@implementation ItemFamilyTb

/**
 根据数据库返回初始化数据
 
 @param resultSet 数据库返回对象
 @return self
 */
- (instancetype)initWithResultSet:(FMResultSet *)resultSet{
    if (self = [super init]) {
        if (nil != resultSet) {
            self.familyName = [resultSet stringForColumn:@"familyName"];
            self.memberCount = [resultSet intForColumn:@"memberCount"];
        }
    }
    return self;
}
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.familyName = [dic objectForKey:@"familyName"];
        self.memberCount = [[dic objectForKey:@"memberCount"] integerValue];
    }
    return self;
}
/**
 表字段名属性数组集合
 
 @return 表字段名属性数组集合@[@[@"字段名", @"类型", @"默认值"], @[@"字段名", @"类型", @"默认值"]]
 */
+ (NSArray *)columnsAttr{
    return @[@[@"familyName", @"TEXT", @"' '"], @[@"memberCount", @"int", @"1"]];
}
@end
