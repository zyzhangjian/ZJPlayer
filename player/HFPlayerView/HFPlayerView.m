//
//  HFStatusView.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/6/1.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "HFPlayerView.h"
#import <AVFoundation/AVFoundation.h>
//视频音量
const float PLAYER_VOLUME = 0.0;

@interface HFPlayerView()

@property (nonatomic,strong) AVPlayer       *player;
@property (nonatomic, copy)  void (^finishBlock)(void);
@property (nonatomic,assign) CMTime         time;
@property (nonatomic,copy)   NSString       *videoPath;
@end

@implementation HFPlayerView

+ (instancetype)videoWithFrame:(CGRect)frame videoPach:(NSString *)path finishBlock:(void(^)(void))block
{
    HFPlayerView *player = [[HFPlayerView alloc]initWithFrame:frame];
    player.finishBlock = block;
    player.videoPath = path;
    return player;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appWillResignActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - 监听是否触发home键挂起程序
- (void)appWillResignActive:(NSNotification *)notification
{
    if (_player){
        [_player pause];
        self.time = self.player.currentTime;
    }
}

#pragma mark - 监听是否重新进入程序程序
- (void)appBecomeActive:(NSNotification *)notification
{
    @try {
        [_player seekToTime:self.time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
            if (finished) [_player play];
        }];
    }@catch (NSException *exception) {
        [_player play];
    }
}

#pragma mark - 监听视频状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status == AVPlayerStatusReadyToPlay){
            [_player play];
            if (self.finishBlock != nil) {
                self.finishBlock();
            }
        }
    }
}
#pragma mark - 监听视频是否播放完成
- (void)moviePlayDidEnd:(NSNotification*)notification
{
    AVPlayerItem *item = [notification object];
    [item seekToTime:kCMTimeZero];
    [_player play];
}

-(void)setVideoPath:(NSString *)videoPath
{
    if ([self isBlankString:videoPath]) return;
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:videoPath]];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    if([[UIDevice currentDevice] systemVersion].intValue>=10){
        //增加下面这行可以解决iOS10兼容性问题了
        self.player.automaticallyWaitsToMinimizeStalling = NO;
    }
    self.player.volume = PLAYER_VOLUME;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerLayer.frame = self.bounds;
    [self.layer addSublayer:playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
}

- (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.player removeObserver:self forKeyPath:@"status"];
    [self.player pause];
    self.player = nil;
}
@end

