//
//  SCCustomNavigationBar.m
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCCustomNavigationBar.h"
#import "UIView+SCLayout.h"

#define kStatusBarHeight      20
#define kTitleLabelPadding    60
#define kButtonPadding        10

#define kNavigationTitleColor   [UIColor blackColor]
#define kNavigationTitleFont    [UIFont systemFontOfSize:17.f]
#define kNavigationBarBgColor   [UIColor whiteColor]

@interface SCCustomNavigationBar ()

@property (nullable, strong, nonatomic) UILabel *titleLabel;
@property (nullable, strong, nonatomic) UIButton *leftButton;
@property (nullable, strong, nonatomic) UIButton *rightButton;
@property (nonnull, strong, nonatomic) UIImageView *bottomShadowView;

@end


@implementation SCCustomNavigationBar


#pragma mark - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始设置
        self.titleTextAttributes = @{NSForegroundColorAttributeName : kNavigationTitleColor,
                                     NSFontAttributeName : kNavigationTitleFont};
        self.backgroundColor = kNavigationBarBgColor;
        
        
        // 添加 subviews
        _leftButton = [[UIButton alloc] init];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_leftButton];
        
        _rightButton = [[UIButton alloc] init];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:_rightButton];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _bottomShadowView = [[UIImageView alloc] init];
        _bottomShadowView.image = [UIImage imageNamed:@"home_bar_shadow"];
        [self addSubview:_bottomShadowView];
        
        _leftButton.hidden = YES;
        _rightButton.hidden = YES;
        _titleLabel.hidden = YES;
        
//        // 布局约束
//        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(kButtonPadding));
//            make.centerY.equalTo(self.mas_centerY).offset(kStatusBarHeight * 0.5);
//            make.width.height.mas_equalTo(44);
//        }];
//
//        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-kButtonPadding);
//            make.centerY.equalTo(self.mas_centerY).offset(kStatusBarHeight * 0.5);
//            make.width.height.mas_equalTo(44);
//        }];
//
//        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.mas_centerX);
//            make.centerY.equalTo(self.mas_centerY).offset(kStatusBarHeight * 0.5);
//            make.left.greaterThanOrEqualTo(_leftButton.mas_right);
//            make.right.lessThanOrEqualTo(_rightButton.mas_left);
//        }];
//
//
//        [_bottomShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(2));
//            make.width.centerX.equalTo(self);
//            make.top.equalTo(self.mas_bottom);
//        }];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftButton.width = 44;
    self.leftButton.height = 44;
    self.leftButton.x = kButtonPadding;
    self.leftButton.centerY = self.centerY + kStatusBarHeight * 0.5;

    // TODO:
}

#pragma mark - Setter
- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    [self p_setupTitleLabel];
}

- (void)setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes {
    _titleTextAttributes = [titleTextAttributes copy];
    
    [self p_setupTitleLabel];
}


- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    _leftBarButtonItem = leftBarButtonItem;
    
    if (leftBarButtonItem) {
        self.leftButton.hidden = NO;
        
        if (leftBarButtonItem.image) {
            [self.leftButton setImage:leftBarButtonItem.image forState:UIControlStateNormal];
        } else {
            [self.leftButton setImage:nil forState:UIControlStateNormal];
        }
        
        if (leftBarButtonItem.customView) {
            [self.leftButton addSubview:leftBarButtonItem.customView];
        }
        
        [self.leftButton addTarget:leftBarButtonItem.target action:leftBarButtonItem.action forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.leftButton.hidden = YES;
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    _rightBarButtonItem = rightBarButtonItem;
    
    if (rightBarButtonItem) {
        self.rightButton.hidden = NO;
        
        if (rightBarButtonItem.image) {
            [self.rightButton setImage:rightBarButtonItem.image forState:UIControlStateNormal];
        } else {
            [self.rightButton setImage:nil forState:UIControlStateNormal];
        }
        
        if (rightBarButtonItem.customView) {
            [self.rightButton addSubview:rightBarButtonItem.customView];
        }
        
        [self.rightButton addTarget:rightBarButtonItem.target action:rightBarButtonItem.action forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.rightButton.hidden = YES;
    }
    
}

#pragma mark - Private methods
- (void)p_setupTitleLabel {
    if (self.title && self.titleTextAttributes) {
        self.titleLabel.hidden = NO;
        self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.title attributes:self.titleTextAttributes];
    } else {
        self.titleLabel.hidden = YES;
    }
}

@end
