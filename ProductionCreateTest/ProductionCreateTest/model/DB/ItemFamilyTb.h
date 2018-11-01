//
//  ItemFamilyTb.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/10/31.
//  Copyright © 2018 TsunamiLi. All rights reserved.
//

#import "DBBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemFamilyTb : DBBase
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, assign) NSInteger memberCount;
@end

NS_ASSUME_NONNULL_END
