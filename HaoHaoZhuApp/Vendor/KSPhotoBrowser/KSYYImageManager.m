//
//  KSWebImage.m
//  KSPhotoBrowserDemo
//
//  Created by Kyle Sun on 22/05/2017.
//  Copyright © 2017 Kyle Sun. All rights reserved.
//

#import "KSYYImageManager.h"

@implementation KSYYImageManager

+ (void)setImageForImageView:(UIImageView *)imageView
                     withURL:(NSURL *)imageURL
                 placeholder:(UIImage *)placeholder
                    progress:(KSImageManagerProgressBlock)progress
                  completion:(KSImageManagerCompletionBlock)completion
{
    YYWebImageProgressBlock progressBlock = ^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progress) {
            progress(receivedSize, expectedSize);
        }
    };
    YYWebImageCompletionBlock completionBlock = ^(UIImage *image,  NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        if (completion) {
            BOOL success = (stage == YYWebImageStageFinished) && !error;
            completion(image, url, success, error);
        }
    };
//    [imageView yy_setImageWithURL:imageURL placeholder:placeholder options:kNilOptions progress:progressBlock transform:nil completion:completionBlock];
//    [imageView setImageWithURL:imageURL placeholder:placeholder options:kNilOptions completion:completionBlock];
    [imageView setImageWithURL:imageURL placeholder:placeholder options:kNilOptions progress:progressBlock transform:nil completion:completionBlock];
}

+ (void)cancelImageRequestForImageView:(UIImageView *)imageView {
//    [imageView yy_cancelCurrentImageRequest];
    [imageView cancelCurrentImageRequest];
}

+ (UIImage *)imageFromMemoryForURL:(NSURL *)url {
    YYWebImageManager *manager = [YYWebImageManager sharedManager];
    NSString *key = [manager cacheKeyForURL:url];
    return [manager.cache getImageForKey:key withType:YYImageCacheTypeMemory];
}

+ (UIImage *)imageForURL:(NSURL *)url {
    YYWebImageManager *manager = [YYWebImageManager sharedManager];
    NSString *key = [manager cacheKeyForURL:url];
    return [manager.cache getImageForKey:key];
}

@end
