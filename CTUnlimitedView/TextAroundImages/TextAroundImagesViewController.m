//
//  TextAroundImagesViewController.m
//  CTUnlimitedView
//
//  Created by boleketang on 16/9/28.
//  Copyright © 2016年 zhuochenming. All rights reserved.
//

#import "TextAroundImagesViewController.h"
#import <CTUnlimitedView/CTUnlimitedView.h>

@interface TextAroundImagesViewController ()<CTUnlimitedViewDelegate>

@property (nonatomic, assign) CTUnlimitedView *attLable;

@end

@implementation TextAroundImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGRect viewRect = CGRectMake(30, 50, 50, 50);
    CGFloat viewWidth = CGRectGetWidth(self.view.frame) - 30;
    
    NSString *text = @"总有一天你将破蛹而出，成长得比人们期待的还要美丽。但这个过程会很痛，会很辛苦，有时候还会觉得灰心。面对着汹涌而来的现实，觉得自己渺小无力。但这，也是生命的一部分。做好现在你能做的，然后，一切都会好的。我们都将孤独地长大，不要害怕。";
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString alignmentStyle:kCTLeftTextAlignment lineSpaceStyle:10 paragraphSpaceStyle:10 lineBreakStyle:0];
    [attString textColor:[UIColor lightGrayColor]];
    [attString font:[UIFont systemFontOfSize:16]];
    
    CTUnlimitedView *ctView = [[CTUnlimitedView alloc] init];
    ctView.attributedText = attString;
    ctView.exclusionRectArray = @[NSStringFromCGRect(viewRect)];
    ctView.tag = 300;
    ctView.delegate = self;
    ctView.frame = CGRectMake(15, 10, viewWidth, [ctView getHeightWithWidth:viewWidth]);
//    CTUnlimitedView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:ctView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:viewRect];
    imgView.backgroundColor = [UIColor redColor];
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage imageNamed:@"33.jpg"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [imgView addGestureRecognizer:panGesture];
    [ctView addSubview:imgView];

    
    _attLable = ctView;
    
    // Do any additional setup after loading the view.
}

- (void)CTUnlimitedView:(CTUnlimitedView *)CTUnlimitedView textContainerClicked:(id<RichTextProtocol>)textContainer atPoint:(CGPoint)point {
    
}

- (void)panView:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:_attLable];
    
    pan.view.center = point;
    _attLable.exclusionRectArray = @[NSStringFromCGRect(pan.view.frame)];
    [_attLable.frameCreator resetFrameRef];
    [_attLable setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
