//
//  YTXTopicCell.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/5.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXTopicCell.h"
#import "YTXTopic.h"
#import <UIImageView+WebCache.h>
#import "YTXUser.h"
#import "YTXComment.h"
#import "YTXTopicPictureView.h"
#import "YTXTopicVoiceView.h"
#import "YTXTopicVideoView.h"

@interface YTXTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/** 中间控件 */
/** 图片控件 */
@property (weak, nonatomic) YTXTopicPictureView *pictureView;
/** 声音控件 */
@property (weak, nonatomic) YTXTopicVoiceView *voiceView;
/** 视频控件 */
@property (weak, nonatomic) YTXTopicVideoView *videoView;
@end


@implementation YTXTopicCell

#pragma mark - 懒加载
- (YTXTopicPictureView *)pictureView
{
    if (!_pictureView) {
        YTXTopicPictureView *pictureView = [YTXTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (YTXTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        YTXTopicVoiceView *voiceView = [YTXTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (YTXTopicVideoView *)videoView
{
    if (!_videoView) {
        YTXTopicVideoView *videoView = [YTXTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(YTXTopic *)topic
{
    _topic = topic;
    
//    YTXLog(@"_small_image == %@", topic.small_image);
//    YTXLog(@"_large_image == %@", topic.large_image);
//    YTXLog(@"_middle_image == %@", topic.middle_image);
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        
        NSString *username = topic.top_cmt.user.username;
        NSString *content = topic.top_cmt.content;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else {
        self.topCmtView.hidden = YES;
    }

#pragma mark - 根据YTXTopic模型数据的情况来决定添加什么空间（内容）
    if (topic.type == YTXTopicTypeVideo) {// 视频
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
    } else if (topic.type == YTXTopicTypeVoice){// 音频
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentF;
        self.voiceView.topic = topic;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    
    } else if (topic.type == YTXTopicTypeWord){// 段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    
    } else if (topic.type == YTXTopicTypePicture){// 图片
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }

    
    
}

/**
 *  设置按钮的数字(placeholder是一个中文参数，故意留到最后，前面的参数就可以使用点语法等职能提示)
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
    
}

/**
 *  重写这个方法的目的：能够拦截所有设置cell frame的操作
 */

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= YTXMargin;
    frame.origin.y += YTXMargin;
    
    [super setFrame:frame];
}

- (IBAction)more {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}



@end
