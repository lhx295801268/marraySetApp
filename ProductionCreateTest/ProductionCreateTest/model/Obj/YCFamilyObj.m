//
//  YCFamilyObj.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/26.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCFamilyObj.h"

@implementation YCFamilyObj
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            self.familyName = [dic objectForKey:@"familyName"];
            self.membersCount = [[dic objectForKey:@"membersCount"] integerValue];
//            self.inviteWeight = [[dic objectForKey:@"inviteWeight"] integerValue];
        }
    }
    return self;
}
@end
