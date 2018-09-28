//
//  YCHttpRequest.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCHttpRequest.h"
#import "AFNetworking.h"
@interface YCHttpRequest()
@property (nonatomic, strong, readonly) NSDictionary *requestDic;
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@end
@implementation YCHttpRequest
- (instancetype)init{
    if (self = [super init]) {
        _requestDic = [[NSDictionary alloc] init];
        self.requestMethod = kYCHttpRequestMethod4Post;
        self.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
    }
    return self;
}
- (void)startRequestHttps{
    
}
- (NSDictionary *)buildParam2Dic{
    return nil;
}
@end
