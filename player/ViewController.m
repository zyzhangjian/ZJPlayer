//
//  ViewController.m
//  player
//
//  Created by Mr.Zhang on 2017/5/31.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HFPlayerView.h"
const float PLAYER_VOLUME1 = 0.0;
@interface ViewController ()
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,assign)CMTime time;
@property(nonatomic,strong)UIView *rootView;
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
