//
//  UIImage+YTXExtension.h
//  百思不得姐
//
//  Created by 俞天 on 16/9/9.
//  Copyright © 2016年 sju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YTXExtension)
/**
 *  返回圆形图片
 */

- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;
@end
