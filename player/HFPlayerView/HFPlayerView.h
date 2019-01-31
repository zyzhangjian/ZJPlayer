//
//  HFStatusView.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/6/1.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFPlayerView : UIView

/**
 创建播放器
 
 @param frame 播放器位置
 @param path  视频路径
 @param block 开始播放回调
 */
+ (instancetype)videoWithFrame:(CGRect)frame videoPach:(NSString *)path finishBlock:(void(^)(void))block;
@end

