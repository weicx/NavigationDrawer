//
//  WRBaseViewController.m
//  抽屉导航
//
//  Created by WR on 15-5-2.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRBaseViewController.h"
#import "WRMenuViewController.h"
#import "WRNavigationController.h"
#import "WRHomeViewController.h"
#import "WRMineViewController.h"
#import "WRSettingViewController.h"
#import "UIView+Extension.h"

#define MENU_WIDTH  260

@interface WRBaseViewController () <WRMenuViewControllerDelegete>

@property (assign, nonatomic) BOOL isopen;
@end

@implementation WRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    // 1.初始化控制器
    WRHomeViewController *homeVC = [[WRHomeViewController alloc] init];
    WRNavigationController *homeNav = [[WRNavigationController alloc] initWithRootViewController:homeVC];
    homeVC.delegate = homeNav;
    [self addChildViewController:homeNav];
    
    WRMineViewController *mineVC = [[WRMineViewController alloc] init];
    WRNavigationController *mineNav = [[WRNavigationController alloc] initWithRootViewController:mineVC];
    mineVC.delegate = mineNav;
    [self addChildViewController:mineNav];
    
    WRSettingViewController *settingVC = [[WRSettingViewController alloc] init];
    WRNavigationController *settingNav = [[WRNavigationController alloc] initWithRootViewController:settingVC];
    settingVC.delegate = settingNav;
    [self addChildViewController:settingNav];
    
    WRMenuViewController *menuVC = [[WRMenuViewController alloc] initWithStyle:UITableViewStyleGrouped];
    menuVC.delegate = self;
    [self addChildViewController:menuVC];
    
    // 2.初始化视图
    menuVC.view.width = MENU_WIDTH;
    [self.view addSubview:menuVC.view];
    [self.view addSubview:homeNav.view];
}

#pragma mark - WRMenuViewControllerDelegete
- (void)menuViewController:(WRMenuViewController *)menuVC changeContentViewFrom:(NSIndexPath *)from to:(NSIndexPath *)to {

    // 取出新、旧控制器
    WRContentViewController *oldVC = self.childViewControllers[from.row];
    WRContentViewController *newVC = self.childViewControllers[to.row];
    
    // 移旧加新
    if (oldVC.view.superview) {// 存在
        [oldVC.view removeFromSuperview];
    }
    newVC.view.frame = oldVC.view.frame;
    [self.view addSubview:newVC.view];
    
    // 这里用通知较为简单
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseMenuView" object:nil];
}
@end
