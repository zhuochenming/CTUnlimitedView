//
//  CustomHUD.h
//  CustomHUD
//
//  Created by 酌晨茗 on 16/3/23.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ConBacColor [UIColor colorWithRed:223 / 255.0 green:223 / 255.0 blue:223 / 255.0 alpha:1]
#define HUDTintColor [UIColor lightGrayColor]

static CGFloat const HUDOffset = 5.0;
static CGFloat const HUDLeftOffset = 10.0;
static CGFloat const HUDWidth = 130.0;
static CGFloat const HUDHeight = 91.0;
static CGFloat const HUDCircleWidth = 64.0;
static CGFloat const HUDLineWidth = 3.0;

@interface CustomHUD : UIView

#pragma mark - 纯文本
+ (void)showWithStatus:(NSString *)status;

#pragma mark - 进度
+ (void)showIndicator;

+ (void)showIndicatorWithStatus:(NSString *)status;

#pragma mark - 进度
+ (void)showProgress;

+ (void)showProgressWithStatus:(NSString *)status;

+ (void)showPhysicsProgress;

+ (void)showPhysicsProgressWithStatus:(NSString *)status;

#pragma mark - 成功
+ (void)showSuccess;

+ (void)showSuccessWithStatus:(NSString *)status;

#pragma mark - 错误
+ (void)showError;

+ (void)showErrorWithStatus:(NSString *)status;

#pragma mark - 移除
+ (void)dismiss;

+ (void)dismissAfterTime:(CGFloat)timeout;

+ (void)dismissWithCompletion:(void (^)(void))completion;

@end
