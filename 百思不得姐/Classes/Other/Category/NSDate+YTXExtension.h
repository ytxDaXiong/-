//
//  NSDate+YTXExtension.h
//  百思不得姐
//
//  Created by 俞天 on 16/9/6.
//  Copyright © 2016年 sju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YTXExtension)
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为明天
 */
- (BOOL)isTomorrow;
@end
