//
//  TextEditor.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "RichTextProtocol.h"
#import <CoreText/CoreText.h>
#import "NSMutableAttributedString+CoreTextMethod.h"

@interface TextEditor : NSObject<RichTextProtocol>

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign) NSRange realRange;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

//下划线样式（单 双）（默认没有）
@property (nonatomic, assign) CTUnderlineStyle underLineStyle;

//下划线样式（点 线）（默认线）
@property (nonatomic, assign) CTUnderlineStyleModifiers modifier;

@end

