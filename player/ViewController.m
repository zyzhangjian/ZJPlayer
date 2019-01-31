//
//  ViewController.m
//  player
//
//  Created by Mr.Zhang on 2017/5/31.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "ViewController.h"
#import "HFPlayerView.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView    *rootImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.rootImageView];
    
    __weak ViewController *weakSelf = self;
    
    [self.view addSubview:[HFPlayerView videoWithFrame:self.view.bounds videoPach:[[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"]finishBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.rootImageView removeFromSuperview];
        });
    }]];
}


- (UIImageView *)rootImageView
{
    if (!_rootImageView) {
        _rootImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _rootImageView.image = [UIImage imageNamed:@"001"];
    }
    return _rootImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

