//
//  WRHomeViewController.m
//  抽屉导航
//
//  Created by WR on 15-5-3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRHomeViewController.h"
#import "WRNavigationController.h"
#import "WRSearchViewController.h"
#import "UIView+Extension.h"

@interface WRHomeViewController ()

@property (strong, nonatomic) WRSearchViewController *searchVC;
@end

@implementation WRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"首页";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_search"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = item;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchCancel) name:@"SearchCancel" object:nil];
}

- (void)search {
    
    [self.navigationController.view addSubview:self.searchVC.view];//要加在导航控制器view上
    self.searchVC.view.frame = CGRectMake(self.view.superview.width, 0, self.view.superview.width, self.view.superview.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.searchVC.view.x = 0;
//        self.navigationController.view.x = -self.navigationController.view.width;
    } completion:^(BOOL finished) {
        [self.searchVC.searchTextField becomeFirstResponder];
    }];
}

- (void)searchCancel {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.searchVC.view endEditing:YES];
        self.searchVC.view.x = self.view.width;
//        self.navigationController.view.x = 0;
        
    } completion:^(BOOL finished) {
        [self.searchVC.view removeFromSuperview];
    }];
}

#pragma mark - lazy
- (WRSearchViewController *)searchVC {

    if (!_searchVC) {
        _searchVC = [[WRSearchViewController alloc] init];
    }
    return _searchVC;
}
@end
