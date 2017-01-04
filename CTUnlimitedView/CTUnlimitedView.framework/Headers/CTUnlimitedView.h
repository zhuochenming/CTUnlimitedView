//
//  CTUnlimitedView.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTFrameCreator.h"

typedef NS_ENUM(NSInteger, DrawType) {
    DrawTextAndPicture, // 图文混排
    DrawPureText,       // 只绘制纯文本
};

@class CTUnlimitedView;
@protocol CTUnlimitedViewDelegate <NSObject>

@optional
- (void)CTUnlimitedViewSelected:(CTUnlimitedView *)CTUnlimitedView;

- (void)CTUnlimitedView:(CTUnlimitedView *)CTUnlimitedView textContainerClicked:(id<RichTextProtocol>)textContainer atPoint:(CGPoint)point;

- (void)CTUnlimitedView:(CTUnlimitedView *)CTUnlimitedView textContainerLongPressed:(id<RichTextProtocol>)textContainer onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point;

@end

@interface CTUnlimitedView : UIView

@property (nonatomic, assign) id<CTUnlimitedViewDelegate> delegate;

//混排类型, 应排版前优先设置
@property (nonatomic, assign) DrawType drawType;

//文本
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSMutableAttributedString *attributedText;

//容器
@property (nonatomic, strong) CTFrameCreator *frameCreator;

//不规则的路径导致布局不美观，所以设定为矩形
@property (nonatomic, strong) NSArray *exclusionRectArray;

//lable属性，参照lable用法
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSInteger numberOfLines;

//链接文本属性
@property (nonatomic, strong) UIColor *linkColor;
@property (nonatomic, strong) UIColor *highlightedLinkColor;

//是否支持复制，默认为YES
@property (nonatomic, assign) BOOL isCopyAvailable;

//高亮色 selectedRadius默认为3
@property (nonatomic, assign) CGFloat selectedRadius;
@property (nonatomic, strong) UIColor *selectColor;

//链接点击高亮色 一起设置才有效 radius默认为3
@property (nonatomic, strong) UIColor *linkBackgroundColor;
@property (nonatomic, assign) CGFloat linkBackgroundRadius;

//文字间距对齐方式
@property (nonatomic, assign) unichar characterSpacing;
@property (nonatomic, assign) CGFloat linesSpacing;
@property (nonatomic, assign) CGFloat paragraphSpacing;

//CoreText方法,属性以kCT开头
@property (nonatomic, assign) CTTextAlignment textAlignment;
@property (nonatomic, assign) CTLineBreakMode lineBreakMode;

//是否使用autoLayout，默认NO(性能有损失)
@property (nonatomic, assign) BOOL isUseAutoLayout;

//根据tag获取添加的<ClickableRichTextProtocol>对象
- (id)richTextWithTag:(NSInteger)tag;

#pragma mark - 处理文本
- (void)insertText:(NSString *)text location:(NSInteger)location;
- (void)insertAttributedString:(NSAttributedString *)attributedText location:(NSInteger)location;

- (void)appendText:(NSString *)text;
- (void)appendAttributedString:(NSAttributedString *)attributedText;

#pragma mark － 文本链接
- (void)addTextEditor:(TextEditor *)textEditor;
- (void)appendTextEditor:(TextEditor *)textEditor;

- (URLEditor *)insertLinkWithLinkData:(id)linkData linkColor:(UIColor *)linkColor underLineStyle:(CTUnderlineStyle)underLineStyle range:(NSRange )range;
- (URLEditor *)appendLinkWithText:(NSString *)linkText linkFont:(UIFont *)linkFont linkColor:(UIColor *)linkColor underLineStyle:(CTUnderlineStyle)underLineStyle linkData:(id)linkData;

#pragma mark - Container
- (void)addContainer:(BaseContainer *)container;
- (void)appendContainer:(BaseContainer *)container;

#pragma mark － UIView扩展
- (ViewContainer *)insertView:(UIView *)view range:(NSRange)range edge:(UIEdgeInsets)edge alignment:(ContainerAlignment)alignment;
- (ViewContainer *)appendView:(UIView *)view edge:(UIEdgeInsets)edge alignment:(ContainerAlignment)alignment;

#pragma mark － 图片扩展
- (ImageContainer *)insertImage:(UIImage *)image range:(NSRange)range size:(CGSize)size edge:(UIEdgeInsets)edge;
- (ImageContainer *)appendImage:(UIImage *)image size:(CGSize)size edge:(UIEdgeInsets)edge;

- (ImageContainer *)insertImageWithName:(NSString *)imageName range:(NSRange)range size:(CGSize)size edge:(UIEdgeInsets)edge;
- (ImageContainer *)appendImageWithName:(NSString *)imageName size:(CGSize)size edge:(UIEdgeInsets)edge;

- (ImageContainer *)insertImageWithURLString:(NSString *)urlstring placeholdImageName:(NSString *)placeholdImageName range:(NSRange)range size:(CGSize)size edge:(UIEdgeInsets)edge;
- (ImageContainer *)appendImageWithURLString:(NSString *)urlstring placeholdImageName:(NSString *)placeholdImageName size:(CGSize)size edge:(UIEdgeInsets)edge;

#pragma mark - 获取高度
- (CGFloat)getHeightWithWidth:(CGFloat)width;
- (CTFrameCreator *)getCTFrameCreatorWithSize:(CGSize)size;

- (void)disableSelectStatus;

@end
