//
//  YTXComment.h
//  百思不得姐
//
//  Created by 俞天 on 16/9/7.
//  Copyright © 2016年 sju. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YTXUser;

@interface YTXComment : NSObject
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户（发表评论的人）*/
@property (nonatomic, strong) YTXUser *user;
@end
