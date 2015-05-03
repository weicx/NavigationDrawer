//
//  WRContentViewController.m
//  抽屉导航
//
//  Created by WR on 15-5-2.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRContentViewController.h"

@interface WRContentViewController ()

@end

@implementation WRContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickMenu:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)didClickMenu:(UIBarButtonItem *)item {

    if ([self.delegate respondsToSelector:@selector(contentViewController:didClickMenu:)]) {
        [self.delegate contentViewController:self didClickMenu:item];
    }
}

@end
