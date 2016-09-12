//
//  YTXLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/26.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXLoginRegisterViewController.h"

@interface YTXLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;


@end

@implementation YTXLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.layer.masksToBounds = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//关闭当前界面
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//显示登录或者注册界面
- (IBAction)showLoginOrRegister:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.leftMargin.constant) {
        //目前显示的是注册界面，点击切换登录界面
        self.leftMargin.constant = 0;
        [button setTitle:@"注册帐号" forState:UIControlStateNormal];
        
    }else{
        //目前是登录界面，点击切换注册界面
        self.leftMargin.constant = -self.view.ytx_width;
        [button setTitle:@"已有帐号？" forState:UIControlStateNormal];
    
    }
    [UIView animateWithDuration:0.25 animations:^{
        //强制刷新:让最新设置的约束值马上应用到UI控件上
        //会刷新self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
