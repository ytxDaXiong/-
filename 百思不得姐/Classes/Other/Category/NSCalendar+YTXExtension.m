//
//  NSCalendar+YTXExtension.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/6.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "NSCalendar+YTXExtension.h"

@implementation NSCalendar (YTXExtension)
+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    
    }
}
@end
