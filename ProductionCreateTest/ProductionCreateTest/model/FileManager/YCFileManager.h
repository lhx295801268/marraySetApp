//
//  YCFileManager.h
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/26.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 文件管理类
 */
@interface YCFileManager : NSObject
/**
 获取document文件夹路径
 */
+ (NSString *)getDocumentFolderPath;

/**
 获取缓存cache目录文件夹位置
 @returnn 路径
 */
+(NSString *)getCachFolderPath;

+(NSString *)getLibraryFolderPath;

/**
 返回tmp文件夹路径
 
 @return 文件夹路径
 */
+(NSString *)getTmpFolderPath;

/**
 查询文件夹 如果没有则创建文件夹
 
 @param desPath 目标文件夹路径
 */
-(void)checkFolderAndCreat:(NSString *)desPath;

/**
 读取文件
 
 @param path 文件路径
 @return 如果没有则返回nil
 */
+(NSData *)readFileData4FilePath:(NSString *)path;

/**
 讲string数据保存到文件中

 @param contentStr 内容str
 @param path 路径
 */
+(void)writeDataToFile:(NSString *)contentStr path:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
