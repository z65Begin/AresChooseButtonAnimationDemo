//
//  HomeBean.m
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import "HomeBean.h"

@implementation HomeBean
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) homeBeanWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}
@end
