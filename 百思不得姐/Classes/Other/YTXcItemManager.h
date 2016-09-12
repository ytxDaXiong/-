//
//  YTXcItemManager.h
//  百思不得姐
//
//  Created by 俞天 on 16/8/25.
//  Copyright © 2016年 sju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTXcItemManager : NSObject


+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
