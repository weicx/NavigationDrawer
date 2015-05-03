//
//  WRNavigationController.m
//  抽屉导航
//
//  Created by WR on 15-5-3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRNavigationController.h"
#import "UIView+Extension.h"

#define MENU_WIDTH             260
#define LEFT_DEVIDE_DISTANCE   40
#define RIGHT_DEVIDE_DISTANCE  220

@interface WRNavigationController () 

@property (assign, nonatomic) BOOL isopen;

@end

@implementation WRNavigationController

+ (void)initialize {
    
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加手势
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentDrag:)]];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTap:)]];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeMenuView) name:@"CloseMenuView" object:nil];
}

#pragma mark - 手势回调
- (void)contentDrag:(UIPanGestureRecognizer *)pan {
    
    CGPoint transform = [pan translationInView:pan.view];
    //    NSLog(@"------- %f", transform.x);
    if (transform.x < 0 && self.view.x == 0) return;
    
    self.view.transform = CGAffineTransformTranslate(self.view.transform, transform.x, 0);
    [pan setTranslation:CGPointZero inView:pan.view];// 每当平移完成后将手势的translation清空
    
    if (pan.state == UIGestureRecognizerStateEnded || pan.state ==UIGestureRecognizerStateCancelled) {// 手势结束或被打断
        
        if (self.view.x < LEFT_DEVIDE_DISTANCE) {// 不到左分界点弹回原位置
            [self closeMenuView];
        } else if (self.view.x > RIGHT_DEVIDE_DISTANCE) {// 越过右分界点移动到菜单展开的位置
            [self openMenuView];
        } else {// 处于左、右分界点之间
            if (self.isopen) {
                [self closeMenuView];
            } else {
                [self openMenuView];
            }
        }
    }
}
- (void)contentTap:(UITapGestureRecognizer *)tap {
    
    [self closeMenuView];
}

#pragma mark - 抽屉打开
- (void)openMenuView {
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.x = MENU_WIDTH;
    } completion:^(BOOL finished) {
        self.isopen = YES;
    }];
}
#pragma mark - 抽屉关闭
- (void)closeMenuView {
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.x = 0;
    } completion:^(BOOL finished) {
        self.isopen = NO;
    }];
}

#pragma mark - WRContentViewControllerDelegate
- (void)contentViewController:(WRContentViewController *)contentVC didClickMenu:(UIBarButtonItem *)menuItem {
    
    if (self.view.x) {
        [self closeMenuView];
    } else {
        [self openMenuView];
    }
}
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
