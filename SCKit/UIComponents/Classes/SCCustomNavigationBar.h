//
//  SCCustomNavigationBar.h
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/**
 * @brief 自定义导航栏，左右按钮（可选），中间标题，底部有阴影线
 *
 * 用法：
 * @code
     YHCustomNavigationBar *navigationBar = [[YHCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
     navigationBar.title = @"挑战";
     navigationBar.leftBarButtonItem = [UIBarButtonItem leftItemWithImage:[UIImage imageNamed:@"community_icon_invite"]
                                                        imageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)
                                                                 target:self
                                                                 action:@selector(leftNavigationBarButtonSelectedAction:)];
     navigationBar.rightBarButtonItem = [UIBarButtonItem rightItemWithImage:[UIImage imageNamed:@"follow_icon_message"]
                                                            imageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, -8)
                                                                     target:self
                                                                  action:@selector(rightNavigationBarButtonSelectedAction:)];
     [self.view addSubview:navigationBar];
    @endcode
 */

@interface SCCustomNavigationBar : UIView

@property (nullable, copy, nonatomic) NSString *title;
@property (nullable, strong, nonatomic) UIBarButtonItem *leftBarButtonItem;
@property (nullable, strong, nonatomic) UIBarButtonItem *rightBarButtonItem;


@property (nullable, copy, nonatomic) NSDictionary<NSString *,id> *titleTextAttributes;

@end


NS_ASSUME_NONNULL_END
