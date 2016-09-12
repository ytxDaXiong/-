//
//  UITextField+YTXExtension.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/29.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "UITextField+YTXExtension.h"

static NSString *const YTXPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (YTXExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //提前设置占位文字，目的:让它提前创建placeholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @"";
    self.placeholder = oldPlaceholder;
    
    //恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
        
    }
    
    //设置占位的文字颜色
    [self setValue:placeholderColor forKeyPath:YTXPlaceholderColorKey];
    

}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:YTXPlaceholderColorKey];
}
@end
