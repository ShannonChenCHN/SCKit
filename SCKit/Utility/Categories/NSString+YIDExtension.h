//
//  NSString+YIDExtension.h
//  YesIDo
//
//  Created by ShannonChen on 16/8/5.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



#define YIDStringNonnull(_string_)     [NSString yid_nonnullStringWithString:_string_]

////////////////////////////////    NSString (YIDExtension)    //////////////////////////////////

@interface NSString (YIDExtension)

/// 为空时，返回 @""，反之，返回 原值
+ (NSString *)yid_nonnullStringWithString:(NSString *)string;

+ (NSString *)yid_stringWithFileSize:(NSUInteger)fileSize;

/// 删除头部和尾部的空格和换行
/// 参考 YYKit https://github.com/ibireme/YYKit
- (NSString *)yid_stringByTrim;

@end



////////////////////////////////    NSString (Hash)    //////////////////////////////////

@interface NSString (Hash)

/// md5 加密
/// 参考 https://github.com/shaojiankui/JKCategories
- (NSString *)yid_md5String;

@end






////////////////////////////////    NSString (Verification)    //////////////////////////////////

@interface NSString (Verification)

/// 是否是手机号
- (BOOL)yid_isMobilePhoneNumber;

/// 有效密码：6~24位数字，英文或下划线任意两种的组合
- (BOOL)yid_isValidPassword;

/// 检查是否是身份证号，18位
- (BOOL)yid_isChineseIdCardNumber;

@end

////////////////////////////////    NSString (Drawing)    //////////////////////////////////

@interface NSString (Drawing)

- (CGSize)yh_sizeForFont:(UIFont *)font;
- (CGSize)yh_sizeForFont:(UIFont *)font maxSize:(CGSize)size;

- (CGFloat)yh_widthForFont:(UIFont *)font;
- (CGFloat)yh_widthForFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGFloat)yh_heightForFont:(UIFont *)font width:(CGFloat)width;
- (CGFloat)yh_heightForFont:(UIFont *)font maxSize:(CGSize)size;
- (CGFloat)yh_heightForFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

@end




NS_ASSUME_NONNULL_END
