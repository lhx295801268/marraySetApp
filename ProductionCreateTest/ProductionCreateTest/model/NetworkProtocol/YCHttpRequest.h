//
//  YCHttpRequest.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, YCHttpRequestMethod) {
    kYCHttpRequestMethod4Post = 0,
    YCHttpRequestMethod4Get,
    YCHttpRequestMethod4Delete
};
NS_ASSUME_NONNULL_BEGIN
@interface YCHttpRequest : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) YCHttpRequestMethod requestMethod;
- (NSDictionary *)buildParam2Dic;
@end
NS_ASSUME_NONNULL_END
