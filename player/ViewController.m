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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:[HFPlayerView videoWithFrame:self.view.bounds videoPach:[[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
