//
//  UIBarButtonItem+YHouse.m
//  YHLibrary
//
//  Created by ShannonChen on 17/4/1.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import "UIBarButtonItem+YHouse.h"
#import <objc/runtime.h>
#import "YHBadgeView.h"

/**
 *  使超出 bounds 范围的子控件也能响应 touch 事件
 */
@interface YHOutsideTouchView : UIView

@end

@implementation YHOutsideTouchView

// allow touches outside view
// https://github.com/Automattic/simplenote-ios/blob/b43ffb63ae188fe263bf7419e44b7075ea7ddf22/Simplenote/Classes/SPOutsideTouchView.h
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    for(UIView *aSubview in self.subviews) {
        UIView *view = [aSubview hitTest:[self convertPoint:point toView:aSubview] withEvent:event];
        if(view) return view;
    }
    return [super hitTest:point withEvent:event];
}

@end

//___________________________________________________________________________________________________________

#define kNavigationBarHeight        44.0
#define kBarButtonImageEdgeInsets   UIEdgeInsetsMake(0, -6, 0, 6)
#define kBarButtonTitleEdgeInsets   UIEdgeInsetsMake(0, 0, 0, 0)


static const char *kYHBarbuttonKey = "kYHBarbuttonKey";
static const char *kYHBarbuttonBadgeValueKey = "kYHBarbuttonBadgeValueKey";
static const char *kYHBarbuttonBadgeTopInsetKey = "kYHBarbuttonBadgeTopInsetKey";
static const char *kYHBarbuttonBadgeRightInsetKey = "kYHBarbuttonBadgeRightInsetKey";

@implementation UIBarButtonItem (YHouse)

#pragma mark - Setter and getter

- (UIButton *)yh_button {
    return objc_getAssociatedObject(self, kYHBarbuttonKey);
}

- (void)setYh_button:(UIButton *)yh_button {
    objc_setAssociatedObject(self, kYHBarbuttonKey, yh_button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)yh_badgeTopInset {
    
    NSNumber *topValue = objc_getAssociatedObject(self, kYHBarbuttonBadgeTopInsetKey);
    YHBadgeView *badgeView = [self badgeView];
    return topValue ? [topValue floatValue] : (badgeView ? badgeView.top : NSNotFound);
}

- (void)setYh_badgeTopInset:(CGFloat)yh_badgeTopInset {
    if (![self.customView isKindOfClass:[YHOutsideTouchView class]]) {
        return;
    }
    
    objc_setAssociatedObject(self, kYHBarbuttonBadgeTopInsetKey, @(yh_badgeTopInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    YHBadgeView *badgeView = [self badgeView];
    badgeView.top = yh_badgeTopInset;
}

- (CGFloat)yh_badgeRightInset {
    NSNumber *rightValue = objc_getAssociatedObject(self, kYHBarbuttonBadgeRightInsetKey);
    YHBadgeView *badgeView = [self badgeView];
    return rightValue ? [rightValue floatValue] : (badgeView ? self.customView.width - badgeView.right : NSNotFound);
}

- (void)setYh_badgeRightInset:(CGFloat)yh_badgeRightInset {
    if (![self.customView isKindOfClass:[YHOutsideTouchView class]]) {
        return;
    }
    
    objc_setAssociatedObject(self, kYHBarbuttonBadgeRightInsetKey, @(yh_badgeRightInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    YHBadgeView *badgeView = [self badgeView];
    badgeView.x = self.customView.width - yh_badgeRightInset - badgeView.width;
}

- (NSInteger)yh_badgeValue {
    return [objc_getAssociatedObject(self, kYHBarbuttonBadgeValueKey) integerValue];
}

- (void)setYh_badgeValue:(NSInteger)yh_badgeValue {
    
    if (![self.customView isKindOfClass:[YHOutsideTouchView class]]) {
        return;
    }
    
    objc_setAssociatedObject(self, kYHBarbuttonBadgeValueKey, @(yh_badgeValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    YHBadgeView *badgeView = [self badgeView];
    
    if (yh_badgeValue > 0) {
        badgeView.hidden = NO;
        
        [badgeView.superview bringSubviewToFront:badgeView];
        badgeView.badge = yh_badgeValue; // badgeView 的 size 是由 badgeValue 决定的
        badgeView.x = self.customView.width - self.yh_badgeRightInset - badgeView.width;
        badgeView.top = self.yh_badgeTopInset;
        
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
    YHBadgeView *badgeView = [[YHBadgeView alloc] initWithPoint:CGPointMake(25.f, 4.f)];
    badgeView.topM = 3;
    badgeView.sideM = 6;
    badgeView.font = [UIFont systemFontOfSize:10.f];
    badgeView.hidden = YES;
    
    // custome view
    YHOutsideTouchView *containerView = [[YHOutsideTouchView alloc] initWithFrame:CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight)];
    [containerView addSubview:button];
    [containerView addSubview:badgeView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    item.yh_button = button;
    
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
    YHBadgeView *badgeView = [[YHBadgeView alloc] initWithPoint:CGPointMake(10.f, 4.f)];
    badgeView.topM = 3;
    badgeView.sideM = 6;
    badgeView.font = [UIFont systemFontOfSize:10.f];
    badgeView.hidden = YES;
    
    // custome view
    YHOutsideTouchView *containerView = [[YHOutsideTouchView alloc] initWithFrame:CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight)];
    [containerView addSubview:button];
    [containerView addSubview:badgeView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    item.yh_button = button;
    
    return item;
}

#pragma mark - Private methods
- (YHBadgeView *)badgeView {
    YHOutsideTouchView *customView = self.customView;
    
    for (UIView *aSubview in customView.subviews) {
        if ([aSubview isKindOfClass:[YHBadgeView class]]) {
            return (YHBadgeView *)aSubview;
        }
    }
    
    return nil;
}

@end
