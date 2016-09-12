//
//  YTXExtensionConfig.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/7.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXExtensionConfig.h"
#import <MJExtension.h>
#import "YTXTopic.h"
#import "YTXComment.h"
@implementation YTXExtensionConfig
+ (void)load
{
    [YTXTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [YTXComment class]};
    }];
    
    [YTXTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};
    }];
}


@end
