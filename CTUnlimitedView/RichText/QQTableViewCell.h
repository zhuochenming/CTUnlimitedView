//
//  QQTableViewCell.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/2/18.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CTUnlimitedView/CTUnlimitedView.h>
#import "QQRoomModel.h"

static CGFloat const QQRoomStaticHeight = 120;

@interface QQTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImgView;

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic, strong) CTUnlimitedView *attriLable;

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIButton *supportButton;

@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) CTUnlimitedView *commentLable;

@property (nonatomic, strong) QQRoomModel *model;

- (void)setContenString:(NSString *)contenString imageNameArray:(NSArray *)imageNameArray urlString:(NSString *)urlstring commentArray:(NSArray *)commentArray;

- (void)setDataWithContainer:(CTFrameCreator *)container commentArray:(NSArray *)commentArray;

@end
