//
//  UUImageCache.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUImageCache : NSObject

//初始化，单例
+ (instancetype)sharedCache;

//图片缓存文件夹
@property (nonatomic, strong, readonly) NSString *imageFilePath;

//最大并行下载数
@property (nonatomic, assign) NSInteger maxDownloadCount;

//是否在本地找到图片,是否需要缩略图,如果需要,就返回素略图
//如果不指定缩略图大小,那么就按照屏幕宽度缩放（一般不会出现超出屏幕长度的图片，如果有特殊需求，就自己指定大小）
- (void)imageForURLString:(NSString *)urlstring
            needThumImage:(BOOL)needThumImage
                    found:(void(^)(UIImage *cachedImage, BOOL isDownloadImage))found
                 notFound:(void(^)())notFound
                    error:(void(^)())error;

- (void)imageForURLString:(NSString *)urlstring
            needThumImage:(BOOL)needThumImage
           thumbImageSize:(CGSize)thumbImageSize
                    found:(void(^)(UIImage *cachedImage, BOOL isDownloadImage))found
                 notFound:(void(^)())notFound
                    error:(void(^)())error;

//异步直接切成圆角
- (void)imageForURLString:(NSString *)urlstring
            needThumImage:(BOOL)needThumImage
                   radius:(CGFloat)radius
                    found:(void(^)(UIImage *cachedImage, BOOL isDownloadImage))found
                 notFound:(void(^)())notFound
                    error:(void(^)())error;

- (void)imageForURLString:(NSString *)urlstring
            needThumImage:(BOOL)needThumImage
           thumbImageSize:(CGSize)thumbImageSize
                   radius:(CGFloat)radius
                    found:(void(^)(UIImage *cachedImage, BOOL isDownloadImage))found
                 notFound:(void(^)())notFound
                    error:(void(^)())error;

- (UIImage *)decodedImageWithImage:(UIImage *)image;

- (void)cancleAllDownLoad;
// 清除cache
- (void)clearCache;

@end
