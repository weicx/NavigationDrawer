//
//  WRMenuViewController.h
//  抽屉导航
//
//  Created by WR on 15-5-2.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRMenuViewController;

@protocol WRMenuViewControllerDelegete <NSObject>

@optional
- (void)menuViewController:(WRMenuViewController *)menuVC changeContentViewFrom:(NSIndexPath *)from to:(NSIndexPath *)to;
//- (void)menuViewController:(WRMenuViewController *)menuVC closeMenuViewWith:(NSIndexPath *)indexPath;
@end

@interface WRMenuViewController : UITableViewController
@property (weak, nonatomic) id <WRMenuViewControllerDelegete> delegate;
@end
