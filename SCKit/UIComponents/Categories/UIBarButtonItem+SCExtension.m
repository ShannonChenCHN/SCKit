//
//  UIBarButtonItem+SCExtension.m
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "UIBarButtonItem+SCExtension.h"
#import "SCOutsideTouchView.h"
#import "SCBadgeView.h"

#import "UIView+SCLayout.h"
#import <objc/runtime.h>


#define kNavigationBarHeight        44.0
#define kBarButtonImageEdgeInsets   UIEdgeInsetsMake(0, -6, 0, 6)
#define kBarButtonTitleEdgeInsets   UIEdgeInsetsMake(0, 0, 0, 0)


static const char *kYHBarbuttonKey = "kYHBarbuttonKey";
static const char *kYHBarbuttonBadgeValueKey = "kYHBarbuttonBadgeValueKey";
static const char *kYHBarbuttonBadgeTopInsetKey = "kYHBarbuttonBadgeTopInsetKey";
static const char *kYHBarbuttonBadgeRightInsetKey = "kYHBarbuttonBadgeRightInsetKey";

@implementation UIBarButtonItem (SCExtension)

#pragma mark - Setter and getter

- (UIButton *)sc_button {
    return objc_getAssociatedObject(self, kYHBarbuttonKey);
}

- (void)setSc_button:(UIButton *)sc_button {
    objc_setAssociatedObject(self, kYHBarbuttonKey, sc_button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)sc_badgeTopInset {
    
    NSNumber *topValue = objc_getAssociatedObject(self, kYHBarbuttonBadgeTopInsetKey);
    SCBadgeView *badgeView = [self badgeView];
    return topValue ? [topValue floatValue] : (badgeView ? badgeView.top : NSNotFound);
}

- (void)setSc_badgeTopInset:(CGFloat)sc_badgeTopInset {
    if (![self.customView isKindOfClass:[SCOutsideTouchView class]]) {
        return;
    }
    
    objc_setAssociatedObject(self, kYHBarbuttonBadgeTopInsetKey, @(sc_badgeTopInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    SCBadgeView *badgeView = [self badgeView];
    badgeView.top = sc_badgeTopInset;
}

- (CGFloat)sc_badgeRightInset {
    NSNumber *rightValue = objc_getAssociatedObject(self, kYHBarbuttonBadgeRightInsetKey);
    SCBadgeView *badgeView = [self badgeView];
    return rightValue ? [rightValue floatValue] : (badgeView ? self.customView.width - badgeView.right : NSNotFound);
}

- (void)setSc_badgeRightInset:(CGFloat)sc_badgeRightInset {
    if (![self.customView isKindOfClass:[SCOutsideTouchView class]]) {
        return;
    }
    
    objc_setAssociatedObject(self, kYHBarbuttonBadgeRightInsetKey, @(sc_badgeRightInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    SCBadgeView *badgeView = [self badgeView];
    badgeView.x = self.customView.width - sc_badgeRightInset - badgeView.width;
}

- (NSInteger)sc_badgeValue {
    return [objc_getAssociatedObject(self, kYHBarbuttonBadgeValueKey) integerValue];
}

- (void)setSc_badgeValue:(NSInteger)sc_badgeValue {
    
    if (![self.customView isKindOfClass:[SCOutsideTouchView class]]) {
        return;
    }
    
    objc_setAssociatedObject(self, kYHBarbuttonBadgeValueKey, @(sc_badgeValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    SCBadgeView *badgeView = [self badgeView];
    
    if (sc_badgeValue > 0) {
        badgeView.hidden = NO;
        
        [badgeView.superview bringSubviewToFront:badgeView];
        badgeView.x = self.customView.width - self.sc_badgeRightInset - badgeView.width;
        badgeView.top = self.sc_badgeTopInset;
        
    } else {
        badgeView.hidden = YES;
    }
    
    
    
}


#pragma mark - Constructor methods

+ (instancetype)leftItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    
    return [self leftItemWithImage:image imageEdgeInsets:kBarButtonImageEdgeInsets target:target action:action];
}

+ (instancetype)leftItemWithImage:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)insets target:(id)target action:(SEL)action {
    
    // 按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight)];
    [button setImage:image forState:UIControlStateNormal];
    button.imageEdgeInsets = insets;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 小红点
    SCBadgeView *badgeView = [[SCBadgeView alloc] init];
    badgeView.minWidth = 15;
    badgeView.hidden = YES;
    
    // custome view
    SCOutsideTouchView *containerView = [[SCOutsideTouchView alloc] initWithFrame:CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight)];
    [containerView addSubview:button];
    [containerView addSubview:badgeView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    item.sc_button = button;
    
    return item;
}

+ (instancetype)rightItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [self rightItemWithImage:image imageEdgeInsets:UIEdgeInsetsZero target:target action:action];
}

+ (instancetype)rightItemWithImage:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)insets target:(id)target action:(SEL)action {
    
    // 按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight)];
    [button setImage:image forState:UIControlStateNormal];
    button.imageEdgeInsets = insets;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 小红点
    SCBadgeView *badgeView = [[SCBadgeView alloc] init];
    badgeView.minWidth = 15;
    badgeView.hidden = YES;
    badgeView.hidden = YES;
    
    // custome view
    SCOutsideTouchView *containerView = [[SCOutsideTouchView alloc] initWithFrame:CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight)];
    [containerView addSubview:button];
    [containerView addSubview:badgeView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    item.sc_button = button;
    
    return item;
}

#pragma mark - Private methods
- (SCBadgeView *)badgeView {
    SCOutsideTouchView *customView = self.customView;
    
    for (UIView *aSubview in customView.subviews) {
        if ([aSubview isKindOfClass:[SCBadgeView class]]) {
            return (SCBadgeView *)aSubview;
        }
    }
    
    return nil;
}

@end
