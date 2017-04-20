//
//  NSString+YIDExtension.m
//  YesIDo
//
//  Created by ShannonChen on 16/8/5.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "NSString+YIDExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

//////////////////////////////////   NSString (YIDExtension)   /////////////////////////////////////////

@implementation NSString (YIDExtension)

+ (NSString *)yid_nonnullStringWithString:(NSString *)string {
    if (string == nil || string == NULL || ![string isKindOfClass:[NSString class]]) {
        return @"";
    }

    return string;
}

+ (NSString *)yid_stringWithFileSize:(NSUInteger)fileSize {
    if (fileSize < 1024) {
        return [NSString stringWithFormat:@"%ldB", (long)fileSize];
    }
    else if (fileSize < 1024 * 1024) {
        CGFloat sizeInKB = (CGFloat)fileSize / 1024;
        return [NSString stringWithFormat:@"%0.2fKB", sizeInKB];
    }
    else if (fileSize < 1024 * 1024 * 1024) {
        CGFloat sizeInMB = (CGFloat)fileSize / (1024 * 1024);
        return [NSString stringWithFormat:@"%0.2fM", sizeInMB];
    }
    else {
        CGFloat sizeInGB = (CGFloat)fileSize / (1024 * 1024 * 1024);
        return [NSString stringWithFormat:@"%0.2fG", sizeInGB];
    }
}

- (NSString *)yid_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}


@end


//////////////////////////////////   NSString (Hash)   /////////////////////////////////////////

@implementation NSString (Hash)

- (NSString *)yid_md5String {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    
    return [self p_yid_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)p_yid_stringFromBytes:(unsigned char *)bytes length:(int)length {
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    
    return [NSString stringWithString:mutableString];
}

@end

//////////////////////////////////   NSString (Verification)   /////////////////////////////////////////

@implementation NSString (Verification)

/// 是否是手机号
- (BOOL)yid_isMobilePhoneNumber {
    if (self.length != 11) {
        return NO;
    }
    NSString *regularExpression = @"1[34578]\\d{9}";//@"(13[0-9]|0[1-9]|0[1-9][0-9]|0[1-9][0-9][0-9]|14[57]|15[0-9]|17[0678]|18[0-9])\\d{8}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
    if ([predicate evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

- (BOOL)yid_isValidPassword {
    NSString *passwordRegEx = @"[0-9A-Za-z]{6,24}";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",passwordRegEx];
    
    return [passwordPredicate evaluateWithObject:self];
}

- (BOOL)yid_isChineseIdCardNumber {
//    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    return [predicate evaluateWithObject:self];
    
    return self.length == 18;
}

@end


//////////////////////////////////   NSString (Drawing)   /////////////////////////////////////////

@implementation NSString (Drawing)

#pragma mark - size calculation

// 尺寸
- (CGSize)yh_sizeForFont:(UIFont *)font {
    CGSize size = [self yh_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size;
}

- (CGSize)yh_sizeForFont:(UIFont *)font maxSize:(CGSize)size {
    return [self yh_sizeForFont:font size:size mode:NSLineBreakByWordWrapping];
}

- (CGSize)yh_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
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
- (CGFloat)yh_widthForFont:(UIFont *)font {
    CGSize size = [self yh_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)yh_widthForFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    CGSize size = [self yh_sizeForFont:font size:CGSizeMake(maxWidth, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}



// 高度
- (CGFloat)yh_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self yh_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGFloat)yh_heightForFont:(UIFont *)font maxSize:(CGSize)size {
    return [self yh_sizeForFont:font size:size mode:NSLineBreakByWordWrapping].height;
}

- (CGFloat)yh_heightForFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    return [self yh_sizeForFont:font size:CGSizeMake(width, HUGE) lineSpacing:lineSpacing].height;
}

- (CGSize)yh_sizeForFont:(UIFont *)font size:(CGSize)size lineSpacing:(CGFloat)lineSpacing {
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



