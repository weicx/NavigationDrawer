//
//  WRMenuViewController.m
//  抽屉导航
//
//  Created by WR on 15-5-2.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRMenuViewController.h"

@interface WRMenuViewController ()

@property (assign, nonatomic) NSIndexPath *currentIndexPath;
@end

@implementation WRMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"menu_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"首页";
            break;
        case 1:
            cell.textLabel.text = @"个人中心";
            break;
        case 2:
            cell.textLabel.text = @"设置";
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(menuViewController:changeContentViewFrom:to:)]) {
        [self.delegate menuViewController:self changeContentViewFrom:self.currentIndexPath to:indexPath];
    }
    
    self.currentIndexPath = indexPath;
}
@end
