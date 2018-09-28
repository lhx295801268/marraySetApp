//
//  YCConclusionObj.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/27.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCConclusionObj.h"
#import "YYModel.h"
#import "YCFileManager.h"
#define YCDefConclusionFileName (@"YCDefConclusionFileName")
@interface YCConclusionObj()

@end
@implementation YCConclusionObj
+ (instancetype)shareIns{
    static dispatch_once_t onceToken;
    static YCConclusionObj *shareIns;
    dispatch_once(&onceToken, ^{
        shareIns = [[YCConclusionObj alloc] init4Instace];
    });
    return shareIns;
}
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (instancetype)init4Instace{
    if (self = [super init]) {
        NSString *filePath = [[YCFileManager getDocumentFolderPath] stringByAppendingPathComponent:YCDefConclusionFileName];
        NSData *data = [YCFileManager readFileData4FilePath:filePath];
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        YCConclusionObj *tempObj = [YCConclusionObj yy_modelWithJSON:jsonStr];
        self.inviteCount = tempObj.inviteCount;
        self.totalCount = tempObj.totalCount;
        self.hotelName = tempObj.hotelName;
        self.deskCount = tempObj.deskCount;
        self.deskPrice = tempObj.deskPrice;
        self.hotelPrice = tempObj.hotelPrice;
        self.weddingCompanyName = tempObj.weddingCompanyName;
        self.weddingPrice = tempObj.weddingPrice;
        self.weddingPicCompanyName = tempObj.weddingPicCompanyName;
        self.weddingPicCompanyPrice = tempObj.weddingPicCompanyPrice;
    }
    return self;
}
- (void)saveAttr{
    NSString *jsonStr = [self yy_modelToJSONString];
    NSString *path = [[YCFileManager getDocumentFolderPath] stringByAppendingPathComponent:YCDefConclusionFileName];
    [YCFileManager writeDataToFile:jsonStr path:path];
}
@end
