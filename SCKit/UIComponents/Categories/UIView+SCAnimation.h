//
//  UIView+SCAnimation.h
//  YHLibrary
//
//  Created by ShannonChen on 17/4/1.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCAnimation)


/**
 点赞动画（点赞或者取消点赞）

 @param config 第一次放大后的设置，比如按钮图片切换
 @param completion 动画结束后的设置，比如按钮旁边文字位置的调整
 */
- (void)yh_startLikeAnimationWithAppearanceConfig:(void (^)(void))config completion:(void (^)(void))completion;


@end

