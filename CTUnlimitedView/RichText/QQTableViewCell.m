//
//  QQTableViewCell.m
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/2/18.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "QQTableViewCell.h"

@implementation QQTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0];
        self.backgroundColor = [UIColor whiteColor];
        self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        [self addSubview:_headImgView];
        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 30)];
        [self addSubview:_nameLable];
        
        self.attriLable = [[CTUnlimitedView alloc] init];
        self.attriLable.backgroundColor = self.backgroundColor;
        self.attriLable.drawType = DrawTextAndPicture;
        
        self.attriLable.frame = CGRectMake(15, CGRectGetMaxY(self.headImgView.frame) + 10, CGRectGetWidth([UIScreen mainScreen].bounds) - 30, 0);
//        self.attriLable.isCopyAvailable = NO;
        [self addSubview:_attriLable];

        self.shareButton = [self customButtonWithTitle:@"分享"];
        [self addSubview:_shareButton];
        
        self.supportButton = [self customButtonWithTitle:@"赞"];
        [self addSubview:_supportButton];
        
        self.commentButton = [self customButtonWithTitle:@"评论"];
        [self addSubview:_commentButton];
        
        self.commentLable = [[CTUnlimitedView alloc] init];
        self.commentLable.backgroundColor = self.backgroundColor;
        self.commentLable.drawType = DrawTextAndPicture;
        [self addSubview:_commentLable];
    }
    return self;
}

- (UIButton *)customButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 0.5;
    button.layer.cornerRadius = 5.0;
    return button;
}

- (void)setModel:(QQRoomModel *)model {
    _model = model;
    [self setContenString:model.title imageNameArray:model.imgNameArray urlString:model.imgURLArray[0] commentArray:model.commentArray];
}

- (void)setContenString:(NSString *)contenString imageNameArray:(NSArray *)imageNameArray urlString:(NSString *)urlstring commentArray:(NSArray *)commentArray {
    //1.先处理纯文本
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:contenString];
    [atr textColor:[UIColor lightGrayColor]];
    [atr font:[UIFont systemFontOfSize:16]];
    [atr textColor:[UIColor redColor]];
    self.attriLable.attributedText = atr;
    
    self.attriLable.linesSpacing = 10;
    self.attriLable.textColor = [UIColor lightGrayColor];
    
    TextEditor *textEditor = [TextEditor new];
    textEditor.text = @"@盗版：坐等你的打脸大招";
    textEditor.range = NSMakeRange(11, 0);
    textEditor.textColor = [UIColor purpleColor];
    textEditor.underLineStyle = kCTUnderlineStyleSingle;
    [self.attriLable addTextEditor:textEditor];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"就喜欢你看不惯我又干不掉我的样子，显得呆萌呆萌哒\n"];
    [attString alignmentStyle:kCTTextAlignmentCenter lineSpaceStyle:10 paragraphSpaceStyle:10 lineBreakStyle:kCTLineBreakByClipping];
    
    [self.attriLable appendAttributedString:attString];
    

    //2.处理链接
    [self.attriLable insertLinkWithLinkData:@"" linkColor:[UIColor greenColor] underLineStyle:kCTUnderlineStyleSingle range:NSMakeRange(5, 5)];
    [self.attriLable appendText:@"\n"];
    [self.attriLable appendLinkWithText:@"@可怜的小八" linkFont:[UIFont systemFontOfSize:14] linkColor:[UIColor orangeColor] underLineStyle:kCTUnderlineStyleSingle linkData:@""];
    [self.attriLable appendText:@"：你丫的\n"];
    //3.处理container
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    lable.text = @"你是逗比";
    [self.attriLable insertView:lable range:NSMakeRange(3, 0) edge:UIEdgeInsetsZero alignment:ContainerAlignmentCenter];
    
    
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    NSInteger attLength = _attriLable.text.length;
    CGFloat width = (screenWidth - 50) / 3.0;
    
    for (int i = 0; i < imageNameArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        imgView.image = [UIImage imageNamed:imageNameArray[i]];
//        imgView.backgroundColor = [UIColor redColor];
        [self.attriLable insertView:imgView range:NSMakeRange(attLength + i, 0) edge:UIEdgeInsetsMake(3, 0, 3, 3) alignment:ContainerAlignmentCenter];
    }

//    for (int i = 0; i < imageNameArray.count; i++) {
////        if (i == 2 || i == 5 || i == 8 || i == 11) {
////            [self.attriLable insertImageWithName:imageNameArray[i] range:NSMakeRange(contenString.length + 10 + i, 0) size:CGSizeMake(width, width) edge:UIEdgeInsetsMake(10, 0, 10, 0)];
////        } else {
////          
////        }
//        ImageContainer *imageContainer = [self.attriLable insertImageWithName:imageNameArray[i] range:NSMakeRange(attLength + i, 0) size:CGSizeMake(width, width) edge:UIEdgeInsetsMake(3, 0, 3, 3)];
//        imageContainer.tag = 3000 + i;
//    }
//
//    NSArray *tagArray = @[@(3002), @(3005), @(3008), @(3011)];
//    for (int i = 0; i < tagArray.count; i++) {
//        ImageContainer *imageContainer = [self.attriLable richTextWithTag:[tagArray[i] integerValue]];
//        imageContainer.edge = UIEdgeInsetsMake(3, 0, 3, 0);
//    }
    
    [self.attriLable appendText:@"\n呵呵哒"];
    [self.attriLable appendAttributedString:[[NSAttributedString alloc] initWithString:@"貌似是拼接的"]];
    
//    NSArray *imgURLStringArray = @[@"http://img.xiuren.com/taotu/355/samples_o/0011.jpg", @"http://img.xiuren.com/taotu/355/samples_o/0043.jpg", @"http://img.xiuren.com/taotu/355/samples_o/0064.jpg", @"http://img.xiuren.com/taotu/1/samples_o/0027.jpg", @"http://img.xiuren.com/taotu/1/samples_o/0044.jpg", @"http://img.xiuren.com/taotu/1/samples_o/0078.jpg", @"http://img.xiuren.com/taotu/1453/samples_o/0001.jpg", @"http://img.xiuren.com/taotu/1453/samples_o/0039.jpg", @"http://img.xiuren.com/taotu/1453/samples_o/0058.jpg"];
//    for (int i = 0; i < imgURLStringArray.count; i++) {
//        [self.attriLable appendImageWithURLString:imgURLStringArray[i] placeholdImageName:@"" size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 30, 500) edge:UIEdgeInsetsMake(10, 0, 10, 0)];
//    }
    
//    [self.attriLable appendImageWithURLString:urlstring placeholdImageName:@"" size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 30, 230) edge:UIEdgeInsetsMake(10, 0, 10, 0)];

    //    NSString *myImageURLString =  @"http://img1.36706.com/lipic/allimg/201312/2-131226223645593.jpg";
//    NSString *myImageURLString =  @"http://imgsrc.baidu.com/forum/pic/item/43ddbcca39dbb6fde9461a5c0124ab18972b37b7.jpg";
//    [self.attriLable appendImageWithURLString:myImageURLString placeholdImageName:@"" size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 300) edge:UIEdgeInsetsZero];
//    [self.attriLable appendAttributedString:[[NSAttributedString alloc] initWithString:@"貌似是拼接的"]];
//    [self.attriLable appendLinkWithText:@"\n拼接的链接" linkFont:[UIFont systemFontOfSize:14] linkColor:[UIColor orangeColor] underLineStyle:kCTUnderlineStyleSingle linkData:@""];
    [self commentLableWithArray:commentArray];
}

- (void)setDataWithContainer:(CTFrameCreator *)container commentArray:(NSArray *)commentArray {
    self.attriLable.frameCreator = container;
    [self commentLableWithArray:commentArray];
}

- (void)commentLableWithArray:(NSArray *)commintArray {
    NSMutableAttributedString *mAttString = [NSMutableAttributedString new];
    for (int i = 0; i < commintArray.count; i++) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:commintArray[i]];
        [attString alignmentStyle:kCTTextAlignmentLeft lineSpaceStyle:1 paragraphSpaceStyle:15 lineBreakStyle:kCTLineBreakByCharWrapping range:NSMakeRange(0, attString.length)];
        [attString underlineColor:[UIColor redColor] range:NSMakeRange(0, 3)];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
        [attString textColor:[UIColor lightGrayColor]];
        [mAttString appendAttributedString:attString];
    }
    self.commentLable.attributedText = mAttString;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
