//
//  HomeBean.h
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeBean : NSObject

@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *image;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)homeBeanWithDict:(NSDictionary *)dict;

@end
