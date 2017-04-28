//
//  UIView+SCAnimation.h
//  YHLibrary
//
//  Created by ShannonChen on 17/4/1.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "UIView+SCAnimation.h"
#import "UIView+SCLayout.h"

@implementation UIView (SCAnimation)


- (void)yh_startLikeAnimationWithAppearanceConfig:(void (^)(void))config completion:(void (^)(void))completion {
    
    [UIView animateWithDuration:0.2 delay:0  options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.layer setValue:@(1.7) forKeyPath:@"transform.scale"]; // 放大
    } completion:^(BOOL finished) {
        
        // 截图、淡出
        UIImage *snapshot = [self yh_snapshotImage];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:snapshot];
        imageView.size = snapshot.size;
        imageView.center = self.center;
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0);
        [self.superview addSubview:imageView];
        [imageView yh_startFadeAwayAnimationWithCompletion:^{
            [imageView removeFromSuperview];
        }];
        
        // 改变外观
        if (config) {
            config();
        }
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.layer setValue:@(0.9) forKeyPath:@"transform.scale"]; // 缩小
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.layer setValue:@(1.1) forKeyPath:@"transform.scale"];  // 放大
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                    [self.layer setValue:@(1) forKeyPath:@"transform.scale"];  // 还原
                } completion:^(BOOL finished) {
                    if (completion) {
                        completion();
                    }
                }];
            }];
        }];
    }];
    
}

/// 变淡
- (void)yh_startFadeAwayAnimationWithCompletion:(void (^)())completion {
    self.alpha = 0.4;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (UIImage *)yh_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

@end
