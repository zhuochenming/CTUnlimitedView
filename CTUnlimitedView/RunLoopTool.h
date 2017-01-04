//
//  RunLoopTool.h
//  RunloopTool
//
//  Created by Zhuochenming on 16/8/30.
//  Copyright © 2016年 Zhuochenming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunLoopTool : NSObject

+ (instancetype)defaultRunLoop;

- (void)addTask:(dispatch_block_t)task key:(id)key;

- (void)removeAllTasks;

@end
