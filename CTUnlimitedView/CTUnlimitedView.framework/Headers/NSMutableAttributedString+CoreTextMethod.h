//
//  NSMutableAttributedString+CoreTextMethod.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

//对齐方式
static NSString * const kTextRunAlignmentName = @"UUAlignment";

@interface NSMutableAttributedString (CoreTextMethod)

#pragma mark - 文本颜色
- (void)textColor:(UIColor *)color;
- (void)textColor:(UIColor *)color range:(NSRange)range;

#pragma mark - 空心字样式
- (void)strockTextWidth:(unichar)width;
- (void)strockTextWidth:(unichar)width range:(NSRange)range;

//设置完空心字宽度后有效
- (void)strockTextColor:(UIColor *)color;
- (void)strockTextColor:(UIColor *)color range:(NSRange)range;

#pragma mark - 文本字体
- (void)font:(UIFont *)font;
- (void)font:(UIFont *)font range:(NSRange)range;

- (void)italicAngle:(CGFloat)angle fontSize:(CGFloat)fontSize;
- (void)italicAngle:(CGFloat)angle fontSize:(CGFloat)fontSize range:(NSRange)range;

#pragma mark - 文本字符间隔
- (void)characterSpacing:(unichar)characterSpacing;
- (void)characterSpacing:(unichar)characterSpacing range:(NSRange)range;

#pragma mark - 下划线样式
- (void)underlineStyle:(CTUnderlineStyle)style modifier:(CTUnderlineStyleModifiers)modifier;
- (void)underlineStyle:(CTUnderlineStyle)style modifier:(CTUnderlineStyleModifiers)modifier range:(NSRange)range;

- (void)underlineColor:(UIColor *)color;
- (void)underlineColor:(UIColor *)color range:(NSRange)range;

#pragma mark - 文本段落样式
- (void)alignmentStyle:(CTTextAlignment)textAlignment lineSpaceStyle:(CGFloat)linesSpacing paragraphSpaceStyle:(CGFloat)paragraphSpacing lineBreakStyle:(CTLineBreakMode)lineBreakMode;
- (void)alignmentStyle:(CTTextAlignment)textAlignment lineSpaceStyle:(CGFloat)linesSpacing paragraphSpaceStyle:(CGFloat)paragraphSpacing lineBreakStyle:(CTLineBreakMode)lineBreakMode range:(NSRange)range;

#pragma mark - 分页
- (NSRange)pageRangeWithSize:(CGSize)size from:(NSInteger)location;
- (NSArray *)pageRangeArrayWithSize:(CGSize)size;

@end
