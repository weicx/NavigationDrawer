//
//  WRSearchViewController.h
//  抽屉导航
//
//  Created by WR on 15-5-3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRSearchViewController : UITableViewController
/**
 *  记录搜索视图的前一个视图  用来做动画效果
 */
@property (strong, nonatomic) UIView *lastView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@end
