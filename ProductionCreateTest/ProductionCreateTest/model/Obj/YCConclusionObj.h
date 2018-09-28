//
//  YCConclusionObj.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/27.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//@"要求来宾数：", @"来宾人数：", @"酒店名称：", @"酒店桌位数量：", @"酒店每个桌位价格：", @"酒店价格：", @"婚庆公司名：", @"婚庆公司价格：：", @"婚纱照公司名：", @"婚纱照公司价格："
@interface YCConclusionObj : NSObject
//要求来宾数：
@property (nonatomic, assign) NSInteger inviteCount;
//来宾人数：
@property (nonatomic, assign) NSInteger totalCount;
//酒店名称：
@property (nonatomic, copy) NSString *hotelName;
//酒店桌位数量：
@property (nonatomic, assign) NSInteger deskCount;
//酒店每个桌位价格：
@property (nonatomic, assign) float deskPrice;
//酒店价格：
@property (nonatomic, assign) float hotelPrice;
//婚庆公司名：
@property (nonatomic, copy) NSString *weddingCompanyName;
//婚庆公司价格：
@property (nonatomic, assign) float weddingPrice;
//婚纱照公司名：
@property (nonatomic, copy) NSString *weddingPicCompanyName;
//婚纱照公司价格：
@property (nonatomic, assign) float weddingPicCompanyPrice;

+ (instancetype)shareIns;
- (void)saveAttr;
@end

NS_ASSUME_NONNULL_END
