//
//  QQInputView.m
//  CTUnlimitedView
//
//  Created by boleketang on 16/9/22.
//  Copyright © 2016年 zhuochenming. All rights reserved.
//

#import "QQInputView.h"

static CGFloat const MessageOffset = 10;
static CGFloat const ContentHeight = 30;

#define LineColor [UIColor colorWithRed:217 / 255.0 green:217 / 255.0 blue:217 / 255.0 alpha:1]

@implementation QQInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1];
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        CGFloat top = (height - ContentHeight) / 2.0;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1.0)];
        lineView.backgroundColor = LineColor;
        [self addSubview:lineView];
        
        self.messageTextField = [[UITextField alloc] initWithFrame:CGRectMake(MessageOffset, top, width - 12 * MessageOffset, ContentHeight)];
        self.messageTextField.textColor = [UIColor lightGrayColor];
        self.messageTextField.font = [UIFont systemFontOfSize:14];
        
        [self setCenterPlaceholder];
        
        self.messageTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_messageTextField];
        
        
        self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.sendButton.frame = CGRectMake(width - 60, top, 50, ContentHeight);
        [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
        
        UIColor *defaultColor = [UIColor colorWithRed:10 / 255.0 green:104 / 255.0 blue:255 / 255.0 alpha:1];
        [self.sendButton setTitleColor:defaultColor forState:UIControlStateNormal];
        
        self.sendButton.layer.cornerRadius = 5;
        [self.sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.sendButton.backgroundColor = [UIColor whiteColor];
        [self.sendButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_sendButton];
    }
    return self;
}

- (void)setCenterPlaceholder {
    NSMutableParagraphStyle *style = [self.messageTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = self.messageTextField.font.lineHeight - (self.messageTextField.font.lineHeight - [UIFont systemFontOfSize:14].lineHeight) / 2.0;
    
    self.messageTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"说点什么吧..." attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style}];
}

@end
