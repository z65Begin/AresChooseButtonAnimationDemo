//
//  Path_NSObject.h
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Path_NSObject : NSObject
/**
 *  获取document目录路径
 *
 *  @return <#return value description#>
 */
-(NSString *)docPath;

/**
 *  路径是否需要创建
 *
 *  @param dirPath <#dirPath description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)isDirNeedCreate:(NSString *)dirPath;

/**
 *  文件是否需要创建
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)isFileNeedCreate:(NSString *)filePath;

/**
 *  添加
 */
-(void) doAdd;
@end
