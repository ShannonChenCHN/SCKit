//
//  NSString+SCExtenstion.m
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "NSString+SCExtenstion.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (SCDrawing)

#pragma mark - size calculation

// 尺寸
- (CGSize)sc_sizeForFont:(UIFont *)font {
    CGSize size = [self sc_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size;
}

- (CGSize)sc_sizeForFont:(UIFont *)font maxSize:(CGSize)size {
    return [self sc_sizeForFont:font size:size mode:NSLineBreakByWordWrapping];
}

- (CGSize)sc_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}



// 宽度
- (CGFloat)sc_widthForFont:(UIFont *)font {
    CGSize size = [self sc_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)sc_widthForFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    CGSize size = [self sc_sizeForFont:font size:CGSizeMake(maxWidth, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}



// 高度
- (CGFloat)sc_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sc_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGFloat)sc_heightForFont:(UIFont *)font maxSize:(CGSize)size {
    return [self sc_sizeForFont:font size:size mode:NSLineBreakByWordWrapping].height;
}

- (CGFloat)sc_heightForFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    return [self sc_sizeForFont:font size:CGSizeMake(width, HUGE) lineSpacing:lineSpacing].height;
}

- (CGSize)sc_sizeForFont:(UIFont *)font size:(CGSize)size lineSpacing:(CGFloat)lineSpacing {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = lineSpacing;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
        
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail];
#pragma clang diagnostic pop
    }
    return result;
}

@end

@implementation NSString (SCHelper)

- (NSString *)sc_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

// 参考：https://github.com/shaojiankui/JKCategories/blob/master/JKCategories/Foundation/NSString/NSString%2BJKHash.m
- (NSString *)sc_md5String {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    
    return [self sc_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sc_stringFromBytes:(unsigned char *)bytes length:(int)length {
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    
    return [NSString stringWithString:mutableString];
}

@end
