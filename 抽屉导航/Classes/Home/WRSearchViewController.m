//
//  WRSearchViewController.m
//  抽屉导航
//
//  Created by WR on 15-5-3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRSearchViewController.h"

@interface WRSearchViewController ()

- (IBAction)cancel:(UIButton *)sender;
@end

@implementation WRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_search_hl"]];
    
    imageView.frame = CGRectMake(0, 0, self.searchTextField.bounds.size.height, self.searchTextField.bounds.size.height);
    
    // 设置图片将光标右移
    self.searchTextField.leftView = imageView;
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;

}

- (IBAction)cancel:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchCancel" object:nil];
}
@end
