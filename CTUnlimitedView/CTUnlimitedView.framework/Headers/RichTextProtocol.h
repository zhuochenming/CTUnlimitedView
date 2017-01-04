
//
//  RichTextProtocol.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TICK NSDate *startTime = [NSDate date]
#define TOCK NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

//富文本名(值为Link or Container)
static NSString * const kTextRunAttributedName = @"CTContent";

@protocol RichTextProtocol <NSObject>

@required

//富文本起始range
@property (nonatomic, assign) NSRange range;
//富文本经过拼接插入等操作后的range
@property (nonatomic, assign) NSRange realRange;

//添加属性到全文attributedString addContainer调用
- (void)addedIntoAttributedString:(NSMutableAttributedString *)attributedString;

- (NSMutableAttributedString *)convertToAttributedString;

@end


@protocol ClickableRichTextProtocol <RichTextProtocol>

@required
@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) CGRect tapRect;

@end

//BaseContainer协议
@protocol BaseContainerProtocol <ClickableRichTextProtocol>

//四周间距
@property (nonatomic, assign) UIEdgeInsets edge;

//添加View 或 绘画 到该区域
- (void)drawContainerWithRect:(CGRect)rect context:(CGContextRef)context;

//设置字体高度 当前字符串替换数
- (void)setTextfontAscent:(CGFloat)ascent descent:(CGFloat)descent;

@end


//ViewContainer和ImageContainer协议
@protocol ViewContainerProtocol <BaseContainerProtocol>

//传递父类view
- (void)transferHoldView:(UIView *)holderView;

//不绘制
- (void)didNotDrawRun;

@end