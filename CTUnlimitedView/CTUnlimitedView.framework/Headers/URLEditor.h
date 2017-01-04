//
//  URLEditor.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "TextEditor.h"

@interface URLEditor : TextEditor<ClickableRichTextProtocol>

@property (nonatomic, assign) CGRect tapRect;

// 点击链接返回的数据
@property (nonatomic, strong) id linkData;

@end
