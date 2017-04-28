//
//  SCMacro.h
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#ifndef SCMacro_h
#define SCMacro_h

// 自定义 log
#ifdef DEBUG
    #define SCLogDebug(s, ... ) NSLog(@"[DEBUG] <%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
    #define SCLogWarn(s, ... ) NSLog(@"[WARN] <%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
    #define SCLogError(s, ...) NSLog(@"[ERROR] <%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
    #define SCLogDebug(s, ...)
    #define SCLogWarn(s, ...)
    #define SCLogError(s, ...)
#endif

// 数组越界保护
#ifndef SCWarningIndexOutOfArrayBounds
#define SCWarningIndexOutOfArrayBounds(__INDEX__, __ARRAY__, ...)  \
    if ([__ARRAY__ count] == 0) { \
        SCLogError(@"Index %li beyond bonds for empty array %p", (long)(__INDEX__), __ARRAY__); \
        return __VA_ARGS__; \
    }\
    if ((__INDEX__) >= [__ARRAY__ count] || (__INDEX__) < 0) {\
        SCLogError(@"Index %li beyond bonds[0...%li]", (long)(__INDEX__), (long)[__ARRAY__ count] - 1);\
        return __VA_ARGS__;\
    }
#endif

#endif /* SCMacro_h */
