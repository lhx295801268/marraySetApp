//
//  YCFamilyObj.h
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/26.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, YCInviteWeight) {
    kYCInviteWeight4Lower = 0,
    kYCInviteWeight4Normal,
    kYCInviteWeight4Height,
    kYCInviteWeight4Default = -1
};

/**
 受邀家庭属性类
 */
@interface YCFamilyObj : NSObject
//家庭主体名称
@property (nonatomic, copy) NSString *familyName;
//成员数量
@property (nonatomic, assign) NSInteger membersCount;
//权重
//@property (nonatomic, assign) YCInviteWeight inviteWeight;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
