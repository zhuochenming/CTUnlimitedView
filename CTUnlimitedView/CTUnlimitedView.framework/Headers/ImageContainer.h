//
//  ImageContainer.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "BaseContainer.h"

typedef NS_ENUM(NSUInteger, ImageAlignment) {
    ImageAlignmentCenter = 0, // 图片居中
    ImageAlignmentLeft = 1,   // 图片左对齐
    ImageAlignmentRight = 2,  // 图片右对齐
};

@interface ImageContainer : BaseContainer<ViewContainerProtocol>

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *imageURLString;
//置位图
@property (nonatomic, strong) NSString *placeholdImageName;
//图片下载完成回调
@property (nonatomic, copy) dispatch_block_t block;

//默认居中
@property (nonatomic, assign) ImageAlignment imageAlignment;

@end
