//
//  WRSearchViewController.m
//  抽屉导航
//
//  Created by WR on 15-5-3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRSearchViewController.h"

#define DEVIDE_DISTANCE   80

@interface WRSearchViewController ()

- (IBAction)cancel:(UIButton *)sender;
@property (strong, nonatomic) UIView *bgView;
@end

@implementation WRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}
// 初始化
- (void)setup {

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_search_hl"]];
    imageView.frame = CGRectMake(0, 0, self.searchTextField.height, self.searchTextField.height);
    
    // 设置图片将输入框光标右移
    self.searchTextField.leftView = imageView;
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    // 添加Pan手势
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(searchViewDrag:)]];
}

#pragma mark - Events
// Pan手势回调
- (void)searchViewDrag:(UIPanGestureRecognizer *)pan {
    
    CGPoint transform = [pan translationInView:pan.view];
    if (self.view.x < 0) {
        self.view.x = 0;
    }
    if (pan.state == UIGestureRecognizerStateEnded || pan.state ==UIGestureRecognizerStateCancelled) {// 拖拽结束或取消
    
        if (self.view.x < DEVIDE_DISTANCE) {
            
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                self.view.x = 0;
                // 复原
                self.lastView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                // 移除、清空遮盖
                [self.bgView removeFromSuperview];
                self.bgView = nil;
            }];
        } else {
            // 确实要离开搜索界面才把键盘退掉
            [self.view endEditing:YES];
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                self.view.x = self.view.width;
                // 复原
                self.lastView.transform = CGAffineTransformIdentity;
                self.bgView.alpha = 0;
            } completion:^(BOOL finished) {
                [self.view removeFromSuperview];
                [self.bgView removeFromSuperview];
                self.bgView = nil;// 记得要将“遮盖”清空
            }];
        }
    } else {// 正在拖拽
        self.view.transform = CGAffineTransformTranslate(self.view.transform, transform.x, 0);
        [pan setTranslation:CGPointZero inView:pan.view];
        
        CGFloat scale = 0.92 + (self.view.x / self.view.width) * 0.08;
        self.lastView.transform = CGAffineTransformMakeScale(scale, scale);
        self.bgView.alpha = 0.5 - (self.view.x / self.view.width) * 0.5;
    }
}

- (IBAction)cancel:(UIButton *)sender {
    
    // 发送“取消”按钮被点击通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchCancel" object:nil];
}

#pragma mark - Lazy
// 用来创建一个“遮盖”效果
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.lastView.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        // 将“遮盖”添加到前一个视图
        [self.lastView addSubview:_bgView];
    }
    return _bgView;
}
@end
