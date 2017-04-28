//
//  NSString+SCExtenstion.h
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SCDrawing)

- (CGSize)sc_sizeForFont:(UIFont *)font;
- (CGSize)sc_sizeForFont:(UIFont *)font maxSize:(CGSize)size;

- (CGFloat)sc_widthForFont:(UIFont *)font;
- (CGFloat)sc_widthForFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGFloat)sc_heightForFont:(UIFont *)font width:(CGFloat)width;
- (CGFloat)sc_heightForFont:(UIFont *)font maxSize:(CGSize)size;
- (CGFloat)sc_heightForFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

@end

@interface NSString (SCHelper)

/// 删除头部和尾部的空格和换行
- (NSString *)sc_stringByTrim;

/// MD5 编码
- (NSString *)sc_md5String;

@end
