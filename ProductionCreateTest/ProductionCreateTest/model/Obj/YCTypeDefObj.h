//
//  YCTypeDefObj.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//
#define YCDefScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define YCDefScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define YCDefImageWithName(name) ((name == nil || name.length <= 0) ? (nil) : ([UIImage imageNamed:imageName]))

typedef void (^ONE_PARAM_BLOCK)(id __nullable param);
typedef void (^TWO_PARAM_BLOCK)(id __nullable param1, id __nullable param2);

typedef NS_ENUM(NSInteger, YCHttpRequestMethod) {
    kYCHttpRequestMethod4Post = 0,
    kYCHttpRequestMethod4Get,
    kYCHttpRequestMethod4Delete
};
