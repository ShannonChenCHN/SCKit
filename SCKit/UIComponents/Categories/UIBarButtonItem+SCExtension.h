//
//  UIBarButtonItem+SCExtension.h
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (SCExtension)

@property (nullable, strong, nonatomic) UIButton *sc_button;
@property (assign, nonatomic) CGFloat sc_badgeRightInset; ///< 数字角标相对 customView 右测内边界的距离
@property (assign, nonatomic) CGFloat sc_badgeTopInset;   ///< 数字角标相对 customView 顶侧内边界的距离
@property (assign, nonatomic) NSInteger sc_badgeValue;

+ (instancetype)leftItemWithImage:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)leftItemWithImage:(nullable UIImage *)image imageEdgeInsets:(UIEdgeInsets)insets target:(nullable id)target action:(nullable SEL)action;

+ (instancetype)rightItemWithImage:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)rightItemWithImage:(nullable UIImage *)image imageEdgeInsets:(UIEdgeInsets)insets target:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
