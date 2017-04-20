//
//  SCImageWriter.m
//  SCImageWriter
//
//  Created by ShannonChen on 17/4/17.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCImageWriter.h"

@implementation SCImageWriter

+ (void)writeToSavedPhotosAlbumWithImage:(UIImage *)image completionHandler:(SCImageWriterCompletionHandler)completionHandler {
    // How to cast blocks to and from void * ？ http://stackoverflow.com/q/11106224/7088321
    // ARC and bridged cast http://stackoverflow.com/questions/7036350/arc-and-bridged-cast
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge_retained void * _Nullable)([completionHandler copy]));
}

+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    SCImageWriterCompletionHandler completionHandler = (__bridge_transfer SCImageWriterCompletionHandler)(contextInfo);
    if (completionHandler) {
        completionHandler(image, error);
    }
}
    


@end
