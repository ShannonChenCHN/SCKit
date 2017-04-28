//
//  SCImageWriter.h
//  SCImageWriter
//
//  Created by ShannonChen on 17/4/17.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SCImageWriterCompletionHandler)(UIImage *image, NSError *error);


/**
 保存图片到相册的工具类
 */
@interface SCImageWriter : NSObject

/// Adds the specified image to the user’s Camera Roll album or the Saved Photos album.
+ (void)writeToSavedPhotosAlbumWithImage:(UIImage *)image completionHandler:(SCImageWriterCompletionHandler)completionHandler;

@end
