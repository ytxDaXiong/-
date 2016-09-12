//
//  YTXTabBarController.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/23.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXTabBarController.h"
#import "YTXTabBar.h"
#import "YTXEssenceViewController.h"
#import "YTXNewViewController.h"
#import "YTXFollowViewController.h"
#import "YTXMeViewController.h"
#import "YTXNavigationController.h"

@interface YTXTabBarController ()
@end

@implementation YTXTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /***** 设置所有UITabBarItem的文字属性*****/
    [self setupItemTitleTextAttributes];
  
    /***添加子控制器***/
    [self setupChildViewControllers];
    
    
    /*** 更换TabBar ***/
    [self setupTabBar];
    
    
    //    UITableViewController * vc0 = [[UITableViewController alloc] init];
//    vc0.view.backgroundColor = [UIColor redColor];
//    vc0.tabBarItem.title = @"精华";
////    [vc0.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
////    [vc0.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//    vc0.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    
//    //    //加载图片
//    //    UIImage *tempImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    //    //产生一张不会进行自动渲染的图片
//    //    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    //    vc0.tabBarItem.selectedImage = selectedImage;
//    vc0.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    [self addChildViewController:vc0];
//    
//    UIViewController *vc1 = [[UIViewController alloc] init];
//    vc1.view.backgroundColor = [UIColor blueColor];
//    vc1.tabBarItem.title =@"新帖";
////    [vc1.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
////    [vc1.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
//    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
//    [self addChildViewController:vc1];
//    
//    UITableViewController *vc2 = [[UITableViewController alloc] init];
//    vc2.view.backgroundColor = [UIColor greenColor];
//    vc2.tabBarItem.title = @"关注";
////    [vc2.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
////    [vc2.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//    [self addChildViewController:vc2];
//    
//    UIViewController *vc3 = [[UIViewController alloc] init];
//    vc3.view.backgroundColor = [UIColor grayColor];
//    vc3.tabBarItem.title = @"我";
////    [vc3.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
////    [vc3.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
//    [self addChildViewController:vc3];

   
    
    
}

- (void)setupItemTitleTextAttributes
{
    /*文字属性*/
    UITabBarItem *item = [UITabBarItem appearance];
    //普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    //选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}


/*
 初始化一个子控制器
 @param vc 子控制器
 @param title 标题
 @param image 图标
 @param selectedImage 选中的图标
 */

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    if (image.length) {//图片名具有值
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    [self addChildViewController:vc];
}

- (void)setupChildViewControllers
{
    [self setupOneChildViewController:[[YTXNavigationController alloc] initWithRootViewController:[[YTXEssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupOneChildViewController:[[YTXNavigationController alloc] initWithRootViewController:[[YTXNewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupOneChildViewController:[[YTXNavigationController alloc] initWithRootViewController:[[YTXFollowViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupOneChildViewController:[[YTXNavigationController alloc] initWithRootViewController:[[YTXMeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}

- (void)setupTabBar
{
    [self setValue:[[YTXTabBar alloc] init] forKey:@"tabBar"];
    
}


@end
