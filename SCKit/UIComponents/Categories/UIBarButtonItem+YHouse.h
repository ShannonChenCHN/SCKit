//
//  UIBarButtonItem+Extension.h
//  YHLibrary
//
//  Created by ShannonChen on 17/4/1.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)

@property (nullable, strong, nonatomic) UIButton *yh_button;
@property (assign, nonatomic) CGFloat yh_badgeRightInset; ///< 数字角标相对 customView 右测内边界的距离
@property (assign, nonatomic) CGFloat yh_badgeTopInset;   ///< 数字角标相对 customView 顶侧内边界的距离
@property (assign, nonatomic) NSInteger yh_badgeValue;

+ (instancetype)leftItemWithImage:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)leftItemWithImage:(nullable UIImage *)image imageEdgeInsets:(UIEdgeInsets)insets target:(nullable id)target action:(nullable SEL)action;

+ (instancetype)rightItemWithImage:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)rightItemWithImage:(nullable UIImage *)image imageEdgeInsets:(UIEdgeInsets)insets target:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
