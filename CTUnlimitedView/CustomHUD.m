//
//  CustomHUD.m
//  CustomHUD
//
//  Created by 酌晨茗 on 16/3/23.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "CustomHUD.h"

@interface CALayer (GradientCircleLayer)

- (void)initGraintCircleWithBounds:(CGRect)bounds position:(CGPoint)position fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor lineWidth:(CGFloat)linewidth;

@end

@implementation CALayer (GradientCircleLayer)

- (NSArray *)graintFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor count:(NSInteger)count {
    CGFloat fromR = 0.0, fromG = 0.0, fromB = 0.0, fromAlpha = 0.0;
    [fromColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromAlpha];
    CGFloat toR = 0.0, toG = 0.0, toB = 0.0, toAlpha = 0.0;
    [toColor getRed:&toR green:&toG blue:&toB alpha:&toAlpha];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i++) {
        CGFloat oneR = fromR + (toR - fromR) / count * i;
        CGFloat oneG = fromG + (toG - fromG) / count * i;
        CGFloat oneB = fromB + (toB - fromB) / count * i;
        CGFloat oneAlpha = fromAlpha + (toAlpha - fromAlpha) / count * i;
        UIColor *onecolor = [UIColor colorWithRed:oneR green:oneG blue:oneB alpha:oneAlpha];
        [result addObject:onecolor];
    }
    return result;
}

- (NSArray *)positionArrayWithMainBounds:(CGRect)bounds {
    CGPoint first = CGPointMake(CGRectGetWidth(bounds) /4 * 3, CGRectGetHeight(bounds) / 4 * 1);
    CGPoint second = CGPointMake(CGRectGetWidth(bounds) /4 * 3, CGRectGetHeight(bounds) / 4 * 3);
    CGPoint thrid = CGPointMake(CGRectGetWidth(bounds) / 4 * 1, CGRectGetHeight(bounds) / 4 * 3);
    CGPoint fourth = CGPointMake(CGRectGetWidth(bounds) / 4 * 1, CGRectGetHeight(bounds) / 4 * 1);
    return @[[NSValue valueWithCGPoint:first], [NSValue valueWithCGPoint:second], [NSValue valueWithCGPoint:thrid], [NSValue valueWithCGPoint:fourth]];
}

- (void)initGraintCircleWithBounds:(CGRect)bounds position:(CGPoint)position fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor lineWidth:(CGFloat)linewidth {
    self.bounds = bounds;
    self.position = position;
    NSArray * colors = [self graintFromColor:fromColor toColor:toColor count:4.0];
    for (int i = 0; i < colors.count -1; i++) {
        CAGradientLayer * graint = [CAGradientLayer layer];
        graint.bounds = CGRectMake(0,0,CGRectGetWidth(bounds)/2,CGRectGetHeight(bounds)/2);
        NSValue *valuePoint = [[self positionArrayWithMainBounds:self.bounds] objectAtIndex:i];
        graint.position = valuePoint.CGPointValue;
        UIColor *fromColor = colors[i];
        UIColor *toColor = colors[i+1];
        NSArray *colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, toColor.CGColor, nil];
        NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
        NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
        NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
        graint.colors = colors;
        graint.locations = locations;
        
        NSArray *startArray = @[[NSValue valueWithCGPoint:CGPointMake(0,0)], [NSValue valueWithCGPoint:CGPointMake(1,0)], [NSValue valueWithCGPoint:CGPointMake(1,1)], [NSValue valueWithCGPoint:CGPointMake(0,1)]];
        NSArray *endArray = @[[NSValue valueWithCGPoint:CGPointMake(1,1)], [NSValue valueWithCGPoint:CGPointMake(0,1)], [NSValue valueWithCGPoint:CGPointMake(0,0)], [NSValue valueWithCGPoint:CGPointMake(1,0)]];
        graint.startPoint = ((NSValue *)[startArray objectAtIndex:i]).CGPointValue;
        graint.endPoint = ((NSValue *)[endArray objectAtIndex:i]).CGPointValue;
        [self addSublayer:graint];
        //Set mask
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        CGRect rect = CGRectMake(0,0,CGRectGetWidth(self.bounds) - 2 * linewidth, CGRectGetHeight(self.bounds) - 2 * linewidth);
        shapelayer.bounds = rect;
        shapelayer.position = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
        shapelayer.strokeColor = [UIColor blueColor].CGColor;
        shapelayer.fillColor = [UIColor clearColor].CGColor;
        shapelayer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetWidth(rect) / 2].CGPath;
        shapelayer.lineWidth = linewidth;
        shapelayer.lineCap = kCALineCapRound;
        shapelayer.strokeStart = 0.015;
        shapelayer.strokeEnd = 0.985;
        [self setMask:shapelayer];
    }
}

@end

@interface CustomHUD ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *drawView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) CAShapeLayer *circleProgressLayer;

@end

@implementation CustomHUD

+ (CustomHUD *)sharedView {
    static CustomHUD *sharedView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [sharedView loadContentView];
    });
    return sharedView;
}

- (void)loadContentView {
    _contentView = [[UIView alloc] init];
    _contentView.layer.cornerRadius = 5.0;
    _contentView.backgroundColor = ConBacColor;
    [self addSubview:_contentView];
}

#pragma mark - 懒加载
- (CAShapeLayer *)circleProgressLayer {
    if (_circleProgressLayer == nil) {
        _circleProgressLayer = [CAShapeLayer layer];
    }
    return _circleProgressLayer;
}

- (UIView *)drawView {
    if (_drawView == nil) {
        _drawView = [[UIView alloc] init];
        [_contentView addSubview:_drawView];
    }
    return _drawView;
}

- (UILabel *)statusLabel {
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.textColor = HUDTintColor;
        _statusLabel.numberOfLines = 0;
        _statusLabel.font = [UIFont systemFontOfSize:14];
        [_contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView =  [[UIActivityIndicatorView alloc] init];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [_contentView addSubview:_indicatorView];
    }
    return _indicatorView;
}

#pragma mark - 配置
- (CGFloat)haveNoLableSetup {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    [self.drawView removeFromSuperview];
    self.drawView = nil;
    self.drawView.frame = CGRectMake((HUDWidth - HUDCircleWidth) / 2.0, (HUDHeight - HUDCircleWidth) / 2.0, HUDCircleWidth, HUDCircleWidth);
    self.contentView.frame = CGRectMake((width - HUDWidth) / 2.0, (height - HUDHeight) / 2.0, HUDWidth, HUDHeight);
    
    return (HUDCircleWidth / 2.0f);
}

- (CGFloat)haveLableSetupWithStatus:(NSString *)status {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    self.statusLabel.text = status;
    CGFloat lableHeight = [self lableHeightWithString:status];
    
    [self.drawView removeFromSuperview];
    self.drawView = nil;
    self.drawView.frame = CGRectMake((HUDWidth - HUDCircleWidth) / 2.0, HUDOffset, HUDCircleWidth, HUDCircleWidth);
    self.statusLabel.frame = CGRectMake(HUDLeftOffset, CGRectGetMaxY(_drawView.frame) + HUDOffset, HUDWidth - 2 * HUDLeftOffset, lableHeight);
    
    CGFloat hudHeight = CGRectGetMaxY(_statusLabel.frame) + HUDOffset;
    _contentView.frame = CGRectMake((width - HUDWidth) / 2.0, (height - hudHeight) / 2.0, HUDWidth, hudHeight);
    
    return (HUDCircleWidth / 2.0f);
}

- (CGFloat)lableHeightWithString:(NSString *)string {
    return [string boundingRectWithSize:CGSizeMake(HUDWidth - 2 * HUDLeftOffset, 0) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _statusLabel.font} context:nil].size.height;
}

#pragma mark - 展示
+ (void)showWithStatus:(NSString *)status {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = NO;
    [contentView.drawView removeFromSuperview];
    contentView.drawView = nil;
    [contentView.indicatorView stopAnimating];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat lableHeight = [contentView lableHeightWithString:status];
    CGFloat viewHeight = lableHeight + 2 * HUDOffset;
    
    contentView.statusLabel.text = status;
    contentView.statusLabel.frame = CGRectMake(HUDLeftOffset, HUDOffset, HUDWidth - 2 * HUDLeftOffset, lableHeight);
    contentView.contentView.frame = CGRectMake((width - HUDWidth) / 2.0, (height - viewHeight) / 2.0, HUDWidth, viewHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

+ (void)showIndicator {
    CustomHUD *contentView = [self sharedView];

    contentView.statusLabel.hidden = YES;
    [contentView.drawView removeFromSuperview];
    contentView.drawView = nil;
    
    contentView.indicatorView.frame = CGRectMake((HUDWidth - HUDCircleWidth) / 2.0, 10, HUDCircleWidth, HUDCircleWidth);
    [contentView.indicatorView startAnimating];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    contentView.contentView.frame = CGRectMake((width - HUDWidth) / 2.0, (height - HUDHeight) / 2.0, HUDWidth, HUDHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

+ (void)showIndicatorWithStatus:(NSString *)status {
    CustomHUD *contentView = [self sharedView];

    contentView.statusLabel.hidden = NO;
    [contentView.drawView removeFromSuperview];
    contentView.drawView = nil;

    contentView.indicatorView.frame = CGRectMake((HUDWidth - HUDCircleWidth) / 2.0, HUDOffset, HUDCircleWidth, HUDCircleWidth);
    [contentView.indicatorView startAnimating];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    contentView.statusLabel.text = status;
    CGFloat lableHeight = [contentView lableHeightWithString:status];
    
    contentView.statusLabel.frame = CGRectMake(2 * HUDOffset, HUDCircleWidth + 2 * HUDOffset, HUDWidth - 4 * HUDOffset, lableHeight);
    
    CGFloat hudHeight = CGRectGetMaxY(contentView.statusLabel.frame) + HUDOffset;
    contentView.contentView.frame = CGRectMake((width - HUDWidth) / 2.0, (height - hudHeight) / 2.0, HUDWidth, hudHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

+ (void)showProgress {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = YES;
    [contentView.indicatorView stopAnimating];
    
    CGFloat radius = [contentView haveNoLableSetup];
    [contentView drawProgressCircleWithRadius:radius fillColor:ConBacColor];
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

+ (void)showProgressWithStatus:(NSString *)status {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = NO;
    [contentView.indicatorView stopAnimating];
    
    CGFloat radius = [contentView haveLableSetupWithStatus:status];
    [contentView drawProgressCircleWithRadius:radius fillColor:ConBacColor];
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

- (void)drawProgressCircleWithRadius:(CGFloat)radius fillColor:(UIColor *)color {
//    CGPoint center = CGPointMake(radius, radius);
//    
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:(radius - 5) startAngle:-45.0f * (M_PI / 180) endAngle:275.0f * (M_PI / 180) clockwise:YES];
//
//    self.circleProgressLayer.path = circlePath.CGPath;
//    self.circleProgressLayer.strokeColor = HUDTintColor.CGColor;
//    self.circleProgressLayer.fillColor = color.CGColor;
//    self.circleProgressLayer.lineWidth = 5;
//    [self.drawView.layer addSublayer:self.circleProgressLayer];
//
//    [self.circleProgressLayer removeAllAnimations];
    
    CALayer *graintCircleLayer = [CALayer layer];
    [graintCircleLayer initGraintCircleWithBounds:self.drawView.frame position:self.drawView.center fromColor:[UIColor whiteColor] toColor:HUDTintColor lineWidth:HUDLineWidth];
    [self.drawView.layer addSublayer:graintCircleLayer];
    
    [self.drawView.layer removeAllAnimations];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0f * 3);
    rotationAnimation.duration = 3.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.drawView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

+ (void)showPhysicsProgress {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = YES;
    [contentView.indicatorView stopAnimating];
    
    CGFloat radius = [contentView haveNoLableSetup];
    [contentView drawPhysicsProgressCircleWithRadius:radius fillColor:ConBacColor];
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

+ (void)showPhysicsProgressWithStatus:(NSString *)status {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = NO;
    [contentView.indicatorView stopAnimating];
    
    CGFloat radius = [contentView haveLableSetupWithStatus:status];
    [contentView drawPhysicsProgressCircleWithRadius:radius fillColor:ConBacColor];
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

- (void)drawPhysicsProgressCircleWithRadius:(CGFloat)radius fillColor:(UIColor *)color {
    UIBezierPath *beizPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:(radius - 5.0) startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = beizPath.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = HUDTintColor.CGColor;
    layer.lineWidth = HUDLineWidth;
    layer.lineCap = kCALineCapRound;
    [self.drawView.layer addSublayer:layer];
    
    [self.drawView.layer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    animation.duration = 0.7;
    animation.repeatCount = HUGE;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.drawView.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark - 成功
+ (void)showSuccess {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = YES;
    [contentView.indicatorView stopAnimating];
    
    CGFloat radius = [contentView haveNoLableSetup];
    [contentView drawSuccessWithRadius:radius color:ConBacColor];
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

+ (void)showSuccessWithStatus:(NSString *)status {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = NO;
    [contentView.indicatorView stopAnimating];
    
    CGFloat radius = [contentView haveLableSetupWithStatus:status];
    [contentView drawSuccessWithRadius:radius color:ConBacColor];
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

- (void)drawSuccessWithRadius:(CGFloat)radius color:(UIColor *)color {
    [self drawCircleWithRadius:radius color:color];
    
    CGFloat drawWith = CGRectGetWidth(self.drawView.bounds);
    CGFloat drawHeight = CGRectGetHeight(self.drawView.bounds);
    
    UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
    [checkmarkPath moveToPoint:CGPointMake(drawWith * 0.28f, drawHeight * 0.53f)];
    [checkmarkPath addLineToPoint:CGPointMake(drawWith * 0.42f, drawHeight * 0.66f)];
    [checkmarkPath addLineToPoint:CGPointMake(drawWith * 0.72f, drawHeight * 0.36f)];
    checkmarkPath.lineCapStyle = kCGLineCapSquare;
    
    CAShapeLayer *checkmarkLayer = [CAShapeLayer layer];
    checkmarkLayer.path = checkmarkPath.CGPath;
    checkmarkLayer.fillColor = nil;
    checkmarkLayer.strokeColor = HUDTintColor.CGColor;
    checkmarkLayer.lineWidth = HUDLineWidth;
    
    [self.drawView.layer addSublayer:self.circleProgressLayer];
    [self.drawView.layer addSublayer:checkmarkLayer];
    
    [self.circleProgressLayer removeAllAnimations];
    [checkmarkLayer removeAllAnimations];
    [self.drawView.layer removeAllAnimations];
    
    //    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //    circleAnimation.duration = 1.0;
    //    circleAnimation.fromValue = @(0);
    //    circleAnimation.toValue = @(1);
    //    circleAnimation.fillMode = kCAFillModeForwards;
    //    circleAnimation.removedOnCompletion = NO;
    //    circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //
    //    [self.circleProgressLayer addAnimation:circleAnimation forKey:@"circleAnimation"];
    
    CABasicAnimation *checkmarkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkmarkAnimation.duration = 1.0;
    checkmarkAnimation.removedOnCompletion = NO;
    checkmarkAnimation.fillMode = kCAFillModeBoth;
    checkmarkAnimation.fromValue = @(0);
    checkmarkAnimation.toValue = @(1);
    checkmarkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [checkmarkLayer addAnimation:checkmarkAnimation forKey:@"strokeEnd"];
}

#pragma mark - 错误
+ (void)showError {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = YES;
    [contentView.indicatorView stopAnimating];
    
    CGFloat radius = [contentView haveNoLableSetup];
    [contentView drawErrorWithRadius:radius color:ConBacColor];
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

+ (void)showErrorWithStatus:(NSString *)status {
    CustomHUD *contentView = [self sharedView];
    
    contentView.statusLabel.hidden = NO;
    [contentView.indicatorView stopAnimating];
    
    CGFloat radius = [contentView haveLableSetupWithStatus:status];
    [contentView drawErrorWithRadius:radius color:ConBacColor];
    [[UIApplication sharedApplication].keyWindow addSubview:contentView];
}

- (void)drawErrorWithRadius:(CGFloat)radius color:(UIColor *)color {
    [self drawCircleWithRadius:radius color:color];
    
    UIBezierPath *crossPath = [UIBezierPath bezierPath];
    
    CGFloat drawWith = CGRectGetWidth(self.drawView.bounds);
    CGFloat drawHeight = CGRectGetHeight(self.drawView.bounds);
    
    [crossPath moveToPoint:CGPointMake(drawWith * 0.72f, drawHeight * 0.27f)];
    [crossPath addLineToPoint:CGPointMake(drawWith * 0.27f, drawHeight * 0.72f)];
    [crossPath moveToPoint:CGPointMake(drawWith * 0.27f, drawHeight * 0.27f)];
    [crossPath addLineToPoint:CGPointMake(drawWith * 0.72f, drawHeight * 0.72f)];
    crossPath.lineCapStyle = kCGLineCapSquare;
    
    CAShapeLayer *crossLayer = [CAShapeLayer layer];
    crossLayer.path = crossPath.CGPath;
    crossLayer.fillColor = nil;
    crossLayer.strokeColor = HUDTintColor.CGColor;
    crossLayer.lineWidth = HUDLineWidth;
    
    [self.drawView.layer addSublayer:self.circleProgressLayer];
    self.circleProgressLayer.strokeColor = HUDTintColor.CGColor;

    [self.drawView.layer addSublayer:crossLayer];
    
    [self.circleProgressLayer removeAllAnimations];
    [self.drawView.layer removeAllAnimations];
    [crossLayer removeAllAnimations];
    
    [self.contentView.layer setValue:@(0) forKeyPath:@"transform.scale"];
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self.contentView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [self.contentView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
    }];
}

#pragma mark - 移除
+ (void)dismiss {
    [[self sharedView] removeFromSuperview];
}

+ (void)dismissAfterTime:(CGFloat)timeout {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

+ (void)dismissWithCompletion:(void (^)(void))completion {
    [[self sharedView] removeFromSuperview];
    completion();
}

#pragma mark - 绘制圆环
- (void)drawCircleWithRadius:(CGFloat)radius color:(UIColor *)color {
    CGPoint center = CGPointMake(radius, radius);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:(radius - 5) startAngle:-90.0f * (M_PI / 180) endAngle:275.0f * (M_PI / 180) clockwise:YES];
    
    self.circleProgressLayer.path = circlePath.CGPath;
    self.circleProgressLayer.strokeColor = HUDTintColor.CGColor;
    self.circleProgressLayer.fillColor = color.CGColor;
    self.circleProgressLayer.lineWidth = HUDLineWidth;
}

@end
