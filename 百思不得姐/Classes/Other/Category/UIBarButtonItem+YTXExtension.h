//
//  UIBarButtonItem+YTXExtension.h
//  百思不得姐
//
//  Created by 俞天 on 16/8/24.
//  Copyright © 2016年 sju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YTXExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
