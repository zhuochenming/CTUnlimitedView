//
//  QQViewController.m
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/2/4.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "QQViewController.h"
#import "QQTableViewCell.h"

#import "QQRoomModel.h"

#import "CustomHUD.h"

#import "QQInputView.h"
#import "RunLoopTool.h"
#import "YYFPSLabel.h"

static NSString *cellIdentifier = @"Cell";

@interface QQViewController ()<CTUnlimitedViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) QQInputView *bottomInputView;

@property (nonatomic, strong) NSMutableArray *cellHeightArray;
@property (nonatomic, strong) NSMutableArray *contentHeightArray;
@property (nonatomic, strong) NSMutableArray *commentHeightArray;

@property (nonatomic, strong) NSMutableArray *modelArray;
//@property (nonatomic, strong) NSMutableArray *containerArray;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, assign) CGFloat currentCellOffset;

@property (nonatomic, assign) CGFloat commentOffset;

@end

@implementation QQViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    KMCGeigerCounter *conter = [KMCGeigerCounter sharedGeigerCounter];
//    conter.enabled = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图文混排";

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[QQTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_tableView];

    [self getNetworkData];
    [self testFPSLabel];
}

- (void)testFPSLabel {
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    fpsLabel.frame = CGRectMake(self.view.frame.size.width - 60, 74, 50, 30);
    [fpsLabel sizeToFit];
    [self.view addSubview:fpsLabel];
    
    // 如果直接用 self 或者 weakSelf，都不能解决循环引用问题
    
    // 移除也不能使 label里的 timer invalidate
    //        [_fpsLabel removeFromSuperview];
}

- (void)getNetworkData {
    [CustomHUD showProgress];
    self.cellHeightArray = [NSMutableArray array];
    self.contentHeightArray = [NSMutableArray array];
    self.commentHeightArray = [NSMutableArray array];
    
    self.modelArray = [NSMutableArray array];
   
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat width = screenWidth - 30;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 300; i++) {
            QQRoomModel *model = [[QQRoomModel alloc] init];
            model.title = [NSString stringWithFormat:@"第%d条，为什么我们总要到过了很久，总要等退无可退，才知道我们曾经亲手舍弃的东西，在后来的日子里再也遇不到了。\n", i];
            
            NSMutableArray *imgNameArray = [NSMutableArray array];
//            for (int i = 1; i < 10; i++) {
//                NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
//                [imgNameArray addObject:imageName];
//            }
            
            for (int i = 0; i < arc4random() % 9; i++) {
                NSString *imageName = [NSString stringWithFormat:@"%u.jpg", arc4random() % 9 + 1];
                [imgNameArray addObject:imageName];
            }
            
            [model.imgNameArray addObjectsFromArray:imgNameArray];
            [model.commentArray addObject:@"小七：我是一枚萌萌哒的逗比,我是一枚萌萌哒的逗比,我是一枚萌萌哒的逗比,重要的事说三遍\n"];
            
            NSArray *urlArray = @[@"http://abc.2008php.com/2013_Website_appreciate/2013-10-23/20131023021015.jpg", @"http://a0.att.hudong.com/15/08/300218769736132194086202411_950.jpg", @"http://img1.3lian.com/2015/w7/90/d/1.jpg", @"http://pic15.nipic.com/20110731/8022110_162804602317_2.jpg", @"http://img4.duitang.com/uploads/item/201205/16/20120516173512_QUjSV.jpeg"];
            NSInteger subCount = arc4random() % (urlArray.count - 1);
            NSArray *subImgArray = [urlArray subarrayWithRange:NSMakeRange(subCount, 1)];
            
            [model.imgURLArray addObjectsFromArray:subImgArray];
            
//            [model.imgURLArray addObject:urlArray[0]];
            [self.modelArray addObject:model];

            //获取cell高度
            QQTableViewCell *cell = [QQTableViewCell new];
            cell.model = model;

            CGFloat heightOne = [cell.attriLable getHeightWithWidth:width];
            CGFloat heightTwo = [cell.commentLable getHeightWithWidth:width];
            
            [self.contentHeightArray addObject:@(heightOne)];
            [self.commentHeightArray addObject:@(heightTwo)];
            
            CGFloat cellHeight = heightOne + heightTwo + QQRoomStaticHeight;
            [self.cellHeightArray addObject:@(cellHeight)];
            
//            CTFrameCreator *frameCreator = [cell.attriLable getCTFrameCreatorWithSize:CGSizeMake(width, heightOne)];
//            [self.containerArray addObject:frameCreator];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [CustomHUD dismiss];
        });
    });
}

#pragma mark - UITableView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    QQTableViewCell *cell = [self.tableView cellForRowAtIndexPath:_selectIndexPath];
    if (cell) {
        [cell.attriLable disableSelectStatus];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellHeightArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_cellHeightArray[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    cell.headImgView.image = [UIImage imageNamed:@"header.jpg"];
    cell.nameLable.text = @"7_______。";
    cell.nameLable.font = [UIFont systemFontOfSize:15];
    
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat width = screenWidth - 30;

    QQRoomModel *model = _modelArray[row];
    cell.model = model;

    CGRect ctFrame = cell.attriLable.frame;
    ctFrame.size.height = [_contentHeightArray[row] floatValue];
    cell.attriLable.frame = ctFrame;
  
    CGFloat top = CGRectGetMaxY(cell.attriLable.frame) + 10;
    cell.shareButton.frame = CGRectMake(15, top, 50, 20);
    cell.supportButton.frame = CGRectMake(screenWidth - 125, top, 50, 20);
    cell.commentButton.frame = CGRectMake(screenWidth - 65, top, 50, 20);
    
    cell.attriLable.delegate = self;
    cell.attriLable.tag = 1000 + row;
    
    cell.commentButton.tag = 3000 + row;
    [cell.commentButton addTarget:self action:@selector(showInputView:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.commentLable.delegate = self;
    cell.commentLable.frame = CGRectMake(15, CGRectGetMaxY(cell.shareButton.frame) + 10, width, [_commentHeightArray[row] floatValue]);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 弹出输入框
- (UIView *)bacView {
    if (_bacView == nil) {
        _bacView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removekeyboard)];
        [_bacView addGestureRecognizer:tap];
    }
    return _bacView;
}

- (QQInputView *)bottomInputView {
    if (_bottomInputView == nil) {
        _bottomInputView = [[QQInputView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.tableView.bounds.size.width, 50)];
        _bottomInputView.messageTextField.delegate = self;
        [_bottomInputView.sendButton addTarget:self action:@selector(sendCommint:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomInputView;
}
- (void)removekeyboard {
    _commentOffset = 0;
    [self.bacView removeFromSuperview];
    [self.bottomInputView.messageTextField resignFirstResponder];
    [self.bottomInputView removeFromSuperview];
}

- (void)showInputView:(UIButton *)button {
    NSInteger row = button.tag - 3000;
    
    CGRect viewrect = [self.tableView convertRect:self.tableView.frame fromView:button];
    _currentCellOffset = CGRectGetMinY(viewrect) + [_commentHeightArray[row] floatValue] + 20 + 64;
    
    [self.view.window addSubview:self.bacView];
    [self.view.window addSubview:self.bottomInputView];
    self.bottomInputView.sendButton.tag = 5000 + row;
    [self.bottomInputView.messageTextField becomeFirstResponder];
}

#pragma mark - 输入框文字改变
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *resultString;
    if (textField.text.length == range.location) {
        resultString = [NSMutableString stringWithFormat:@"%@%@", textField.text, string];
    } else {
        resultString = [NSMutableString stringWithString:textField.text];
        [resultString replaceCharactersInRange:range withString:string];
    }
    
    if ([resultString isEqualToString:@""]) {
        [self makeButtonNotWork];
    } else {
        self.bottomInputView.sendButton.enabled = YES;
        [self.bottomInputView.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bottomInputView.sendButton.backgroundColor = [UIColor colorWithRed:0 green:182 / 255.0 blue:248 / 255.0 alpha:1];
    }
    return YES;
}

- (void)makeButtonNotWork {
    self.bottomInputView.sendButton.enabled = NO;
    [self.bottomInputView.sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.bottomInputView.sendButton.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 发表评论
- (void)sendCommint:(UIButton *)button {
    if (![self.bottomInputView.messageTextField.text isEqualToString:@""]) {
        NSInteger row = button.tag - 5000;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        QQTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        CGFloat lastCommintOffset = CGRectGetHeight(cell.commentLable.frame);
        
        QQRoomModel *model = self.modelArray[row];
        NSString *commint = [NSString stringWithFormat:@"小七：%@\n", self.bottomInputView.messageTextField.text];
        [model.commentArray addObject:commint];
        
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 30;
        [cell.commentLable appendText:commint];
        CGFloat lableHeight = [cell.commentLable getHeightWithWidth:width];
        
        CGFloat oriHight = [self.cellHeightArray[row] floatValue];
        CGFloat offsetHeight = lableHeight - [self.commentHeightArray[row] floatValue];
        CGFloat cellHeight = oriHight + offsetHeight;
        [self.commentHeightArray replaceObjectAtIndex:row withObject:@(lableHeight)];
        [self.cellHeightArray replaceObjectAtIndex:row withObject:@(cellHeight)];
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        CGFloat offset = lableHeight - lastCommintOffset;
        _commentOffset = offset;
        if (offset) {
            CGFloat currentOffset = self.tableView.contentOffset.y;
            [self.tableView setContentOffset:CGPointMake(0, offset + currentOffset) animated:YES];
        }
        self.bottomInputView.messageTextField.text = @"";
        [self makeButtonNotWork];
    }
}

#pragma mark - CTUnlimitedView代理
- (void)CTUnlimitedViewSelected:(CTUnlimitedView *)CTUnlimitedView {
    _selectIndexPath = [NSIndexPath indexPathForRow:CTUnlimitedView.tag - 1000 inSection:0];
}

- (void)CTUnlimitedView:(CTUnlimitedView *)CTUnlimitedView textContainerClicked:(id<RichTextProtocol>)textContainer atPoint:(CGPoint)point; {

    if ([textContainer isKindOfClass:[ImageContainer class]]) {
        ImageContainer *image = (ImageContainer *)textContainer;

        UIImageView *bacView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        bacView.image = image.image;
        bacView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        bacView.userInteractionEnabled = YES;
        bacView.contentMode = UIViewContentModeScaleAspectFit;
        bacView.tag = 3100;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImage:)];
        [bacView addGestureRecognizer:tap];
        
        [[UIApplication sharedApplication].keyWindow addSubview:bacView];
    }
    NSLog(@"%@", NSStringFromRange(textContainer.realRange));
}

- (void)CTUnlimitedView:(CTUnlimitedView *)CTUnlimitedView textContainerLongPressed:(id<RichTextProtocol>)textContainer onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point {
    NSLog(@"%@", CTUnlimitedView.text);
}

#pragma mark - 键盘位置改变
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaddShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboaddShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
 
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.bottomInputView.center = CGPointMake(self.bottomInputView.center.x, keyBoardEndY - self.bottomInputView.bounds.size.height / 2.0);
    }];
    
    CGFloat offset = _currentCellOffset - keyBoardEndY + 3 + _commentOffset;
    [self.tableView setContentOffset:CGPointMake(0, offset) animated:YES];
}

- (void)dismissImage:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = [[UIApplication sharedApplication].keyWindow viewWithTag:3100];
    [imageView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
