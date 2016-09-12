//
//  YTXRecommendTagCell.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/9.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXRecommendTagCell.h"
#import "YTXRecommendTag.h"
#import <UIImageView+WebCache.h>


@interface YTXRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end
@implementation YTXRecommendTagCell

- (void)setRecommendTag:(YTXRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    //头像
    [self.imageListView setHeader:recommendTag.image_list];
    
    //名字
    self.themeNameLabel.text = recommendTag.theme_name;
    
    //订阅数
    if (recommendTag.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }
}
/**
 *  重写setFrame:作用：监听设置cell的frame的过程
 */

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
