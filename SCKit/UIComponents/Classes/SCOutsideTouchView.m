//
//  SCOutsideTouchView.m
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCOutsideTouchView.h"

@implementation SCOutsideTouchView

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
