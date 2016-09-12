//
//  YTXTopicViewController.h
//  百思不得姐
//
//  Created by 俞天 on 16/9/8.
//  Copyright © 2016年 sju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTXTopic.h"
@interface YTXTopicViewController : UITableViewController
/** 帖子的类型 */
// @property (nonatomic, assign) XMGTopicType type;
- (YTXTopicType)type;

// 这个属性会生成一个type的get方法 和 _type成员变量
// @property (nonatomic, assign, readonly) XMGTopicType type;

@end
