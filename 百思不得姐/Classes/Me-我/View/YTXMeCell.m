//
//  YTXMeCell.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/29.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXMeCell.h"

@implementation YTXMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    self.imageView.ytx_y = YTXSmallMargin;
    self.imageView.ytx_height = self.contentView.ytx_height - 2 * YTXSmallMargin;
    self.imageView.ytx_width = self.imageView.ytx_height;
    //label
    self.textLabel.ytx_x = self.imageView.ytx_right + YTXMargin;
}
@end
