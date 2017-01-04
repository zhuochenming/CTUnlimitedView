//
//  CTFrameCreator.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RichTextProtocol.h"

//文本处理
#import "TextEditor.h"
#import "URLEditor.h"

//view容器
#import "BaseContainer.h"
#import "ViewContainer.h"
#import "ImageContainer.h"

@interface CTFrameCreator : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSMutableAttributedString *attributedText;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *linkColor;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) NSInteger numberOfLines;
@property (nonatomic, assign) unichar characterSpacing;
@property (nonatomic, assign) CGFloat linesSpacing;
@property (nonatomic, assign) CGFloat paragraphSpacing;

@property (nonatomic, assign) CTTextAlignment textAlignment;
@property (nonatomic, assign) CTLineBreakMode lineBreakMode;

@property (nonatomic, strong) NSArray *exclusionRectArray;

@property (nonatomic, strong, readonly) NSArray *textContainerArray;
//调用- (CTFrameRef)getFrameRefWithSize:(CGSize)size方法后有值
@property (nonatomic, assign, readonly) CTFrameRef frameRef;

#pragma mark - 文本
- (void)insertText:(NSString *)text location:(NSInteger)location;
- (void)insertAttributedString:(NSAttributedString *)attributedText location:(NSInteger)location;

- (void)appendText:(NSString *)text;
- (void)appendAttributedString:(NSAttributedString *)attributedText;

- (void)addTextEditor:(TextEditor *)textEditor;
- (void)appendTextEditor:(TextEditor *)textEditor;

#pragma mark - 容器
- (void)addContainer:(BaseContainer *)container;
- (void)appendContainer:(BaseContainer *)container;

#pragma mark - 获取文本高度
- (CGFloat)getSuggestHeightWithWidth:(CGFloat)width;

#pragma mark - 生成frameFef
- (CTFrameRef)getFrameRefWithSize:(CGSize)size;

#pragma mark - 遍历
- (id<ClickableRichTextProtocol>)richTextWithTag:(NSInteger)tag;

- (BOOL)isHaveClickableRichText;
- (BOOL)isHaveClickableLink;
- (BOOL)isHaveClickableContainer;

- (void)traversalContainer:(void(^)(BaseContainer *container, CGRect rect))block;
- (BOOL)traversalLinkOfClickPoint:(CGPoint)point viewHeight:(CGFloat)viewHeight callBack:(void (^)(URLEditor *linkText))block;

- (BOOL)enumerateRunRectContainPoint:(CGPoint)point viewHeight:(CGFloat)viewHeight successBlock:(void (^)(id<RichTextProtocol> textContainer))successBlock;

//根据point获取点击的CTRun的location
- (NSInteger)locationOfCTRunWithPoint:(CGPoint)point rect:(CGRect)rect;
//根据point获取点击的CTRun的range
- (NSRange)rangeOfCTRunWithPoint:(CGPoint)point rect:(CGRect)rect;
//根据range获取CTRun的rect
- (CGRect)rectOfCTRunWithRange:(NSRange)range size:(CGSize)size;
- (void)resetLocation;
//合并range
- (void)combineSelectedRangeArray:(NSMutableArray *)rangeArray newRange:(NSRange)newRange;

#pragma mark - 重置CTFrameRef
- (void)resetFrameRef;

@end
