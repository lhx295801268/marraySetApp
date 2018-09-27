//
//  YCListObj.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/27.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCFamilyObj.h"
NS_ASSUME_NONNULL_BEGIN

@interface YCListObj : NSObject
@property (nonatomic, strong) NSArray<YCFamilyObj *> *familyObjList;
@end

NS_ASSUME_NONNULL_END
