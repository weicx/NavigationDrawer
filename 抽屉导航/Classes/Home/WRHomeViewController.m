//
//  WRHomeViewController.m
//  抽屉导航
//
//  Created by WR on 15-5-3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRHomeViewController.h"
#import "WRSearchViewController.h"

@interface WRHomeViewController ()

@property (strong, nonatomic) WRSearchViewController *searchVC;
@end

@implementation WRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

// 初始化
- (void)setup {

    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"首页";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_search"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = item;
    
    // 注册通知  监听“取消”按钮的点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchCancel) name:@"SearchCancel" object:nil];
}
#pragma mark - Events
- (void)search {
    // 搜索视图要加在最底层的控制器view上
    [self.navigationController.view.superview addSubview:self.searchVC.view];
    self.searchVC.view.frame = CGRectMake(self.searchVC.view.width, 0, self.searchVC.view.width, self.searchVC.view.height);
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        // 这一句是为了动画效果
        self.navigationController.view.x = - self.navigationController.view.width * 0.3;
        self.searchVC.view.x = 0;
    } completion:^(BOOL finished) {
        [self.searchVC.searchTextField becomeFirstResponder];
        // 动画结束位置复原（位置复原目的是为了Pan手势拖动搜索视图时方便做动画效果）
        self.navigationController.view.x = 0;
    }];
}

- (void)searchCancel {
    // 这一句也是为了动画效果
    self.navigationController.view.x = - self.navigationController.view.width * 0.3;

    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.searchVC.view.x = self.searchVC.view.width;
        self.navigationController.view.x = 0;
        [self.searchVC.view endEditing:YES];
    } completion:^(BOOL finished) {
        [self.searchVC.view removeFromSuperview];
    }];
}

#pragma mark - Lazy
- (WRSearchViewController *)searchVC {
    if (!_searchVC) {
        _searchVC = [[WRSearchViewController alloc] init];
        // 给属性赋值  记录前一个视图（即导航控制器视图）用来做动画
        _searchVC.lastView = self.navigationController.view;
    }
    return _searchVC;
}
@end
