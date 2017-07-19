//
//  CustomButtonViewController.m
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "CustomButtonViewController.h"
#import "SCCustomButton.h"

@interface CustomButtonViewController ()

@property (strong, nonatomic) IBOutlet SCCustomButton *avatarButton;
@property (strong, nonatomic) IBOutlet SCCustomButton *viewMoreButton;
@property (strong, nonatomic) IBOutlet SCCustomButton *wideLocationButton;
@property (strong, nonatomic) IBOutlet SCCustomButton *likeButton;
@property (strong, nonatomic) IBOutlet SCCustomButton *highLocationButton;

@end

@implementation CustomButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    // 头像
    self.avatarButton.imagePosition = SCCustomButtonImagePositionTop;
    self.avatarButton.interTitleImageSpacing = 5;
    self.avatarButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.avatarButton.imageCornerRadius = 25;
    
    
    // 查看更多
    self.viewMoreButton.imagePosition = SCCustomButtonImagePositionRight;
    
    // 位置1
    self.wideLocationButton.imagePosition = SCCustomButtonImagePositionLeft;
    self.wideLocationButton.interTitleImageSpacing = 15;
    self.wideLocationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    
    // 点赞
    self.likeButton.imagePosition = SCCustomButtonImagePositionTop;
    self.likeButton.interTitleImageSpacing = 10;
    self.likeButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    // 位置2
    self.highLocationButton.imagePosition = SCCustomButtonImagePositionBottom;
    self.highLocationButton.interTitleImageSpacing = 5;
    self.highLocationButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;

}



@end
