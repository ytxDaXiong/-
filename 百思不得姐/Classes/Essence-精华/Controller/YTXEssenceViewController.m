//
//  YTXEssenceViewController.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/24.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXEssenceViewController.h"
#import "YTXTitleButton.h"
#import "YTXAllViewController.h"
#import "YTXVideoViewController.h"
#import "YTXVoiceViewController.h"
#import "YTXPictureViewController.h"
#import "YTXWordViewController.h"
#import "YTXRecommendTagViewController.h"
@interface YTXEssenceViewController () <UIScrollViewDelegate>
/**当前选中的标题按钮*/
@property (nonatomic, weak) YTXTitleButton *selectedTitleButton;
/**标题按钮底部的指示器*/
@property (nonatomic, weak) UIView *indicatorView;
/**UIScrollView*/
@property (nonatomic, weak) UIScrollView *scrollView;
/**标题栏*/
@property (nonatomic, weak) UIView *titlesView;
@end

@implementation YTXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupChildViewControllers];
    [self setupScrollView];
    [self setupTitlesView];
    
    //默认添加子控制器的view
    [self addChildVcView];
}

- (void)setupChildViewControllers
{
    YTXAllViewController *all = [[YTXAllViewController alloc] init];
    [self addChildViewController:all];
    
    YTXVideoViewController *video = [[YTXVideoViewController alloc] init];
    [self addChildViewController:video];
    
    YTXVoiceViewController *voice = [[YTXVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    YTXPictureViewController *picture = [[YTXPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    YTXWordViewController *word = [[YTXWordViewController alloc] init];
    [self addChildViewController:word];
}

- (void)setupScrollView
{
    //不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    //添加所有子控制器的view到scrollView中
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count* scrollView.ytx_width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
//    NSUInteger count = self.childViewControllers.count;
//    for (NSUInteger i = 0; i < count; i++) {
//        UITableView *childVcView = (UITableView *)self.childViewControllers[i].view;
//        childVcView.backgroundColor = YTXRandomColor;
//        childVcView.ytx_x = i * childVcView.ytx_width;
//        childVcView.ytx_y = 0;
//        childVcView.ytx_height = scrollView.ytx_height;
//        [scrollView addSubview:childVcView];
//        //内边距
//        childVcView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
//        childVcView.scrollIndicatorInsets = childVcView.contentInset;
//    }
//    scrollView.contentSize = CGSizeMake(count *scrollView.ytx_width, 0);
    
    
}

- (void)setupNav
{
    //标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}



- (void)setupTitlesView
{
    //标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.frame = CGRectMake(0, 64, self.view.ytx_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //添加标题
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.ytx_width /count;
    CGFloat titleButtonH = titlesView.ytx_height;
    
    for (NSUInteger i = 0; i < count; i++) {
        //创建按钮
        YTXTitleButton *titleButton = [YTXTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        //设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        //设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
    }
    //按钮选中的颜色
    YTXTitleButton *firstTitleButton = titlesView.subviews.firstObject;
    
    //底部指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.ytx_height = 1;
    indicatorView.ytx_y = titlesView.ytx_height - indicatorView.ytx_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    //立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.ytx_width = firstTitleButton.titleLabel.ytx_width;
    indicatorView.ytx_centerX = firstTitleButton.ytx_centerX;
    
    //默认情况：选中最前面的标题按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
    
}

#pragma mark 监听点击
- (void)titleClick:(YTXTitleButton *)titleButton
{
    //控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    //指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.ytx_width = titleButton.titleLabel.ytx_width;
        self.indicatorView.ytx_centerX = titleButton.ytx_centerX;
    }];
    
    //让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.ytx_width;
    [self.scrollView setContentOffset:offset animated:YES];
}


- (void)tagClick
{
    YTXRecommendTagViewController *tag = [[YTXRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:tag animated:YES];
}

#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    //子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.ytx_width;
    //取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    
    if ([childVc isViewLoaded]) return;

    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  在scrollView滚动动画结束时，就会调用这个方法
    前提:使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画。
 */

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

/**
 *  在scrollView滚动动画结束时，就会调用这个方法
 *
 *  前提：人为拖拽scrollView产生的滚动动画
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.ytx_width;
    YTXTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleClick:titleButton];
    
    //添加子控制器的view
    [self addChildVcView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
