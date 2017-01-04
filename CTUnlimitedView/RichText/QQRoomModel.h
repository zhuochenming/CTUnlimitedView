//
//  QQRoomModel.h
//  CTUnlimitedView
//
//  Created by boleketang on 16/8/19.
//  Copyright © 2016年 zhuochenming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQRoomModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableArray *imgNameArray;

@property (nonatomic, strong) NSMutableArray *imgURLArray;

@property (nonatomic, strong) NSMutableArray *commentArray;

@end
