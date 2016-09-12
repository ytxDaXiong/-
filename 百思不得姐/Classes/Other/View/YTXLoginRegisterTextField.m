//
//  YTXLoginRegisterTextField.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/26.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXLoginRegisterTextField.h"

static NSString *const YTXPlaceholderColorKey = @"placeholderLabel.textColor";
@implementation YTXLoginRegisterTextField

- (void)awakeFromNib
{
    //设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    //设置占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:YTXPlaceholderColorKey];
    
    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    //监听文字的改变
//    [self addTarget:self action:@selector(editingChange) forControlEvents:UIControlEventEditingChanged];

    
//    //设置占位文字颜色
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
    
    // @property(nullable, nonatomic,copy)   NSAttributedString     *attributedPlaceholder;
    
    //    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    //    attributes[NSForegroundColorAttributeName] = [UIColor yellowColor];
    //    attributes[NSBackgroundColorAttributeName] = [UIColor redColor];
    //    attributes[NSUnderlineStyleAttributeName] = @YES;
    //    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
    
    //    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
    //    // 设置属性
    //    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    //    attributes[NSForegroundColorAttributeName] = [UIColor yellowColor];
    //    [string setAttributes:attributes range:NSMakeRange(0, 1)];
    //
    //    NSMutableDictionary *attributes2 = [NSMutableDictionary dictionary];
    //    attributes2[NSBackgroundColorAttributeName] = [UIColor redColor];
    //    attributes2[NSUnderlineStyleAttributeName] = @YES;
    //    [string setAttributes:attributes2 range:NSMakeRange(0, 2)];
    //    [string addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, 1)];
    //    [string addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    //    [string addAttribute:NSUnderlineStyleAttributeName value:@YES range:NSMakeRange(1, 1)];
    //    self.attributedPlaceholder = string;
}

/**
 * 开始编辑
 **/
- (void)editingDidBegin
{
    [self setValue:[UIColor whiteColor] forKeyPath:YTXPlaceholderColorKey];
}
/**
 * 结束编辑
 **/

- (void)editingDidEnd
{
    [self setValue:[UIColor grayColor] forKeyPath:YTXPlaceholderColorKey];
}


@end
