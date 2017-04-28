//
//  SCBadgeView.m
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCBadgeView.h"
#import "UIView+SCLayout.h"
#import "NSString+SCExtenstion.h"

@implementation SCBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:60/255.0 blue:50/255.0 alpha:1.0];
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:12];
        
        _minWidth = 10;
    }
    return self;
}

- (void)setText:(NSString *)text {
    if (text.integerValue > 99) {
        text = @"99+";
    }
    [super setText:text];
    [self sizeToFit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.text.length) {  // 没有数字的小红点
        CGFloat dotWH = self.minWidth;
        
        CGFloat adjustXOffset = dotWH - self.width;
        self.width = dotWH;
        self.x -= adjustXOffset;
        
        CGFloat adjustYOffset = dotWH - self.height;
        self.height = dotWH;
        self.y -= adjustYOffset;
    }
    else {                      // 有数字的小红点
        
        // 调整宽度，x 位置
        CGFloat width = [self.text sc_widthForFont:self.font];
        width = width > self.height ? width : self.height;
        if (self.text.length > 1) {
            width += 5;
        }
        CGFloat adjustXOffset = width - self.width;
        self.width = width;
        self.x -= adjustXOffset;
    }
    
    // 圆角
    self.layer.cornerRadius = self.height / 2.0;
    self.layer.masksToBounds = YES;
}

@end
