//
//  SCBadgeView.h
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 按钮上的小红点，没有数字时展示红点，有数字则展示数字
 * 初始化时：使用 [[SCBadgeView alloc] init]; 然后设置位置即可，尺寸默认自适应
 */
@interface SCBadgeView : UILabel

@property (assign, nonatomic) CGFloat minWidth;  // 默认 10

@end
