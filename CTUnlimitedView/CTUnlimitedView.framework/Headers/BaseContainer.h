//
//  BaseContainer.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "RichTextProtocol.h"

//typedef enum : NSUInteger {
//    ContainerAlignmentTop,     // 底部齐平 向上伸展
//    ContainerAlignmentCenter,  // 中心齐平
//    ContainerAlignmentBottom,  // 顶部齐平 向下伸展
//} ContainerAlignment;

typedef NS_ENUM(NSUInteger, ContainerAlignment) {
    ContainerAlignmentTop,     // 底部齐平 向上伸展
    ContainerAlignmentCenter,  // 中心齐平
    ContainerAlignmentBottom,  // 顶部齐平 向下伸展
};

@interface BaseContainer : NSObject<BaseContainerProtocol>

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) CGRect tapRect;

@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign) NSRange realRange;

//画板大小
@property (nonatomic, assign) CGSize size;
//容器四周间距
@property (nonatomic, assign) UIEdgeInsets edge;

//对齐方式
@property (nonatomic, assign) ContainerAlignment containerAlignment;

//获取绘画区域上行高度(默认实现)
- (CGFloat)getDrawerAreaAscentHeight;

//获取绘画区域下行高度 默认实现为0（一般不需要改写）
- (CGFloat)getDrawerAreaDescentHeight;

//获取绘画区域宽度（默认实现）
- (CGFloat)getDrawerAreaWidth;

//释放内存 （一般不需要 已注释 需要在打开）
//- (void)DrawRunDealloc;

@end
