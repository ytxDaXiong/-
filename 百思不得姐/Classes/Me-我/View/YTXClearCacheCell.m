//
//  YTXClearCacheCell.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/31.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXClearCacheCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

@implementation YTXClearCacheCell

#define YTXCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置cell右边的指示器（用来说明正在处理一些事情）
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        //设置cell默认的文字
        self.textLabel.text = @"清除缓存（正在计算缓存大小...）";
        
        self.userInteractionEnabled = NO;
        
        __weak typeof(self) weakself = self;
        //在子线程中计算缓存大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [NSThread sleepForTimeInterval:5.0];
            //获得缓存文件夹路径
            unsigned long long size = YTXCustomCacheFile.fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            
            if(weakself == nil) return;
            
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) {
                sizeText = [NSString stringWithFormat:@"%.2fGB",size / pow(10, 9)];
            } else if (size >= pow(10, 6)){
                sizeText = [NSString stringWithFormat:@"%.2fMB",size / pow(10, 6)];
            } else if (size >= pow(10, 3)){
                sizeText = [NSString stringWithFormat:@"%.2fKB",size / pow(10, 3)];
            } else {
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            
            
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置文字
                weakself.textLabel.text = text;
                //清除右边的指示器
                weakself.accessoryView = nil;
                //显示右边的箭头
                weakself.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                //添加手势监听器
                [weakself addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakself action:@selector(clearCache)]];
                
                //恢复点击事件
                weakself.userInteractionEnabled = YES;
            });
        });
    }
    return self;
}

- (void)clearCache
{
    //弹出指示器
    [SVProgressHUD showWithStatus:@"正在清除缓存..." maskType:SVProgressHUDMaskTypeCustom];
    //删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        //删除自定义缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:YTXCustomCacheFile error:nil];
            [mgr createDirectoryAtPath:YTXCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
            [NSThread sleepForTimeInterval:5.0];
            //所有缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
                //隐藏指示器
                [SVProgressHUD dismiss];
               //设置文字
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
    }];
}

/**
 *  当cell重新显示到屏幕上时，也会调用一次layoutSybviews
 */

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //cell重新显示的时候，继续转圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}

@end
