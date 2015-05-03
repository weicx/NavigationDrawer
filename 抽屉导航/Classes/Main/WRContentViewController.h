//
//  WRContentViewController.h
//  抽屉导航
//
//  Created by WR on 15-5-2.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRContentViewController;

@protocol WRContentViewControllerDelegate <NSObject>

@optional
- (void)contentViewController:(WRContentViewController *)contentVC didClickMenu:(UIBarButtonItem *)menuItem;

@end

@interface WRContentViewController : UIViewController

@property (weak, nonatomic) id <WRContentViewControllerDelegate> delegate;
@end
