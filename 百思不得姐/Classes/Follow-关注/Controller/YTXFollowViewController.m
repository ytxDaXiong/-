//
//  YTXFollowViewController.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/24.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXFollowViewController.h"
#import "YTXRecommendFollowViewController.h"
#import "YTXLoginRegisterViewController.h"
@interface YTXFollowViewController ()

@end

@implementation YTXFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YTXCommonBgColor;
    
    //标题（不建议使用self.title属性）
    self.navigationItem.title = @"我的关注";
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
    
}
- (IBAction)loginRegister {
    YTXLoginRegisterViewController *follow = [[YTXLoginRegisterViewController alloc] init];
    [self.navigationController presentViewController:follow animated:YES completion:nil];
    
}


- (void)followClick
{
    YTXLogFunc
    YTXRecommendFollowViewController *follow = [[YTXRecommendFollowViewController alloc] init];
    [self.navigationController pushViewController:follow animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
