//
//  YTXTopicCell.h
//  百思不得姐
//
//  Created by 俞天 on 16/9/5.
//  Copyright © 2016年 sju. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTXTopic;
@interface YTXTopicCell : UITableViewCell

/** 帖子模型数据 */
@property (nonatomic, strong) YTXTopic *topic;
@end
