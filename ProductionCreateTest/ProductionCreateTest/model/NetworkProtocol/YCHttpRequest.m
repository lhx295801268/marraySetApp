//
//  YCHttpRequest.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCHttpRequest.h"
#import "AFNetworking.h"
#import "YCPathConfig.h"
@interface YCHttpRequest()
@property (nonatomic, strong, readonly) NSDictionary *requestDic;
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@property (nonatomic, copy) ONE_PARAM_BLOCK progressBlock;
@property (nonatomic, copy) ONE_PARAM_BLOCK sucBlock;
@property (nonatomic, copy) ONE_PARAM_BLOCK failedBlock;
@end
@implementation YCHttpRequest
- (instancetype)init{
    if (self = [super init]) {
        _requestDic = [[NSDictionary alloc] init];
        self.requestMethod = kYCHttpRequestMethod4Post;
        self.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}
- (void)startRequestHttps:(ONE_PARAM_BLOCK)sucBlock failedBlock:(ONE_PARAM_BLOCK)failedBlock {
//    _progressBlock = progressBlock;
    _sucBlock = sucBlock;
    _failedBlock = failedBlock;
    NSDictionary *paramDic = [self buildParam2Dic];
    //拼接访问的url地址
    NSString *perfectUrl = YCDefRootUrl;
    if (nil != self.url && self.url.length > 0) {
        perfectUrl = [YCDefRootUrl stringByAppendingString: [NSString stringWithFormat:@"/%@", self.url]];
    }
    perfectUrl = @"https://www.baidu.com";
    __block __weak YCHttpRequest *self_weak = self;
    if (self.requestMethod == kYCHttpRequestMethod4Post) {
        [self.httpManager POST:perfectUrl parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *textStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", textStr);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }else if(self.requestMethod == kYCHttpRequestMethod4Get){
        [self.httpManager GET:perfectUrl parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *textStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", textStr);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }
}
- (NSDictionary *)buildParam2Dic{
    return nil;
}
@end
