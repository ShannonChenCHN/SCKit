//
//  YHHourglassLoadingView.m
//  YHLibrary
//
//  Created by ShannonChen on 17/3/16.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import "YHHourglassLoadingView.h"
#import "NSTimer+Addition.h"

@interface YHHourglassLoadingView ()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentContainerView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UILabel *animatingDotLabel;


@property (strong, nonatomic) NSTimer *timer;

@end

@implementation YHHourglassLoadingView

#pragma mark - Life cycle
- (void)dealloc {
    [self p_invalidTimer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        self.removeFromSuperviewWhenStopped = YES;
        
        [self p_setupSubviews];
    }
    
    return self;
}

- (void)p_setupSubviews {
    // 背景
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    [self addSubview:_backgroundView];
    
    // 白色方块
    _contentContainerView = [[UIView alloc] init];
    _contentContainerView.backgroundColor = [UIColor whiteColor];
    _contentContainerView.layer.cornerRadius = 2;
    _contentContainerView.layer.masksToBounds = YES;
    [self addSubview:_contentContainerView];
    
    // 图片（沙漏）
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_hourglass"]];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    // 文字提示
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.numberOfLines = 1;
    _messageLabel.font = [UIFont systemFontOfSize:15];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.textColor = HEXCOLOR(0x111111);
    [self addSubview:_messageLabel];
    
    // 文字提示后面的“...”
    _animatingDotLabel = [[UILabel alloc] init];
    _animatingDotLabel.numberOfLines = 1;
    _animatingDotLabel.font = _messageLabel.font;
    _animatingDotLabel.textAlignment = NSTextAlignmentLeft;
    _animatingDotLabel.textColor = _messageLabel.textColor;
    [self addSubview:_animatingDotLabel];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@150);
        make.height.equalTo(@120);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_contentContainerView.mas_top).offset(35);
        make.width.equalTo(@20);
        make.height.equalTo(@22);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(-3);
        make.top.equalTo(_imageView.mas_bottom).offset(15);
    }];
    
    [_animatingDotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_messageLabel.mas_right);
        make.centerY.equalTo(_messageLabel);
    }];
}

#pragma mark - Public methods
- (void)setMessage:(NSString *)message {
    _message = [message copy];
    
    self.messageLabel.text = message;
}

- (void)startAnimating {
    [self p_invalidTimer];
    
    self.hidden = NO;
    self.animatingDotLabel.text = @"...";
    
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer yh_timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer *timer) {
        if ([weakSelf.animatingDotLabel.text isEqualToString:@""]) {
            weakSelf.animatingDotLabel.text = @".";
        }
        else if ([weakSelf.animatingDotLabel.text isEqualToString:@"."]) {
            weakSelf.animatingDotLabel.text = @"..";
        }
        else if ([weakSelf.animatingDotLabel.text isEqualToString:@".."]) {
            weakSelf.animatingDotLabel.text = @"...";
        }
        else if ([weakSelf.animatingDotLabel.text isEqualToString:@"..."]) {
            weakSelf.animatingDotLabel.text = @"";
        }
        
    }];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopAnimating {
    [self p_invalidTimer];
    
    
    if (self.removeFromSuperviewWhenStopped) {
        [self removeFromSuperview];
    } else {
        self.hidden = YES;
    }
    
}

#pragma mark - Private methods
- (void)p_invalidTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
