//
//  AutolayoutViewController.m
//  CTUnlimitedView
//
//  Created by boleketang on 16/9/28.
//  Copyright © 2016年 zhuochenming. All rights reserved.
//

#import "AutolayoutViewController.h"
#import <CTUnlimitedView/CTUnlimitedView.h>
#import "Masonry.h"

@interface AutolayoutViewController ()<CTUnlimitedViewDelegate>

@end

@implementation AutolayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSString *text = @"小七：我是一枚萌萌哒的逗比,我是一枚萌萌哒的逗比,我是一枚萌萌哒的逗比,重要的事说三遍\n";
    
    NSArray *array = @[text, text, text, text];
    NSMutableAttributedString *attString = [self commentLableWithArray:array];
    CTUnlimitedView *ctView = [[CTUnlimitedView alloc] init];
    ctView.attributedText = attString;
    ctView.tag = 300;
    //    CTUnlimitedView.numberOfLines = 3;
    ctView.lineBreakMode = kCTLineBreakByTruncatingTail;
    ctView.delegate = self;
    [self.view addSubview:ctView];
    
    ctView.isUseAutoLayout = YES;
    [ctView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    // Do any additional setup after loading the view.
}

- (NSMutableAttributedString *)commentLableWithArray:(NSArray *)commintArray {
    //    self.commentLable.attributedText = [NSMutableAttributedString new];
    NSMutableAttributedString *mAttString = [NSMutableAttributedString new];
    for (int i = 0; i < commintArray.count; i++) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:commintArray[i]];
        [attString alignmentStyle:kCTTextAlignmentJustified lineSpaceStyle:1 paragraphSpaceStyle:15.0 lineBreakStyle:kCTLineBreakByClipping range:NSMakeRange(0, 3)];
        [attString underlineColor:[UIColor redColor] range:NSMakeRange(0, 3)];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
        [mAttString appendAttributedString:attString];
    }
    return mAttString;
}

- (void)CTUnlimitedView:(CTUnlimitedView *)CTUnlimitedView textContainerClicked:(id<RichTextProtocol>)textContainer atPoint:(CGPoint)point {
    
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
