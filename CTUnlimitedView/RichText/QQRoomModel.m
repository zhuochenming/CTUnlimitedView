
//
//  QQRoomModel.m
//  CTUnlimitedView
//
//  Created by boleketang on 16/8/19.
//  Copyright © 2016年 zhuochenming. All rights reserved.
//

#import "QQRoomModel.h"

@implementation QQRoomModel

- (NSMutableArray *)imgNameArray {
    if (_imgNameArray == nil) {
        _imgNameArray = [NSMutableArray array];
    }
    return _imgNameArray;
}

- (NSMutableArray *)imgURLArray {
    if (_imgURLArray == nil) {
        _imgURLArray = [NSMutableArray array];
    }
    return _imgURLArray;
}

- (NSMutableArray *)commentArray {
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

@end
