//
//  SCHourglassLoadingView.h
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCHourglassLoadingView : UIView

@property (copy, nonatomic) NSString *message; ///< 加载时要显示的文字，后面不用再加“...”，动画开始时会自动添加
@property (assign, nonatomic) BOOL removeFromSuperviewWhenStopped;  ///< 默认 YES. 如果为 YES，当动画停止时，内部调用 - removeFromSuperview 方法；如果为 NO，当动画停止时，内部调用 - setHidden: 方法隐藏

- (void)startAnimating;
- (void)stopAnimating;


@end

NS_ASSUME_NONNULL_END
