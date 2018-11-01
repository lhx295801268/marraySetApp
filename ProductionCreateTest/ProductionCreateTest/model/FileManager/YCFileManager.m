//
//  YCFileManager.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/26.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCFileManager.h"

@implementation YCFileManager

/**
 获取document文件夹路径
 */
+ (NSString *)getDocumentFolderPath{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return  [pathList firstObject];
}

+(NSString *)getDBFolderPath{
    NSString *resultFolderPath = [self getDocumentFolderPath];
    resultFolderPath = [resultFolderPath stringByAppendingPathComponent:@"DBFolder"];
    [self checkFolderAndCreat:resultFolderPath];
    return resultFolderPath;
}

/**
 获取缓存cache目录文件夹位置
 @returnn 路径
 */
+(NSString *)getCachFolderPath{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [pathList firstObject];
}

+(NSString *)getLibraryFolderPath{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [pathList firstObject];
}

/**
 返回tmp文件夹路径

 @return 文件夹路径
 */
+(NSString *)getTmpFolderPath{
    return NSTemporaryDirectory();
}

/**
 查询文件夹 如果没有则创建文件夹

 @param desPath 目标文件夹路径
 */
+(void)checkFolderAndCreat:(NSString *)desPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDire = true;
    if (![fileManager fileExistsAtPath:desPath isDirectory:&isDire]) {
         //如果不存在文件夹 开始创建文件夹
        [fileManager createDirectoryAtPath:desPath withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        if (!isDire) {//如果存在同名文件 但是不是文件夹 则删除文件 重新创建文件夹
            [fileManager createDirectoryAtPath:desPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
}

/**
 读取文件

 @param path 文件路径
 @return 如果没有则返回nil
 */
+(NSData *)readFileData4FilePath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+(void)writeDataToFile:(NSString *)contentStr path:(NSString *)path{
    if (contentStr.length <= 0 || path.length <= 0) {
        return;
    }
    NSError *wrightErro = nil;
    [contentStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&wrightErro];
    if (wrightErro) {
        NSLog(@"写入文件错误：%@", wrightErro);
    }
}
@end
