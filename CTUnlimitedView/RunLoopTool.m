//
//  RunLoopTool.m
//  RunloopTool
//
//  Created by Zhuochenming on 16/8/30.
//  Copyright © 2016年 Zhuochenming. All rights reserved.
//

#import "RunLoopTool.h"

@interface RunLoopTool()

@property (nonatomic, assign) CFRunLoopObserverRef observer;

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSMutableArray *tasksKeys;

@end

@implementation RunLoopTool

+ (instancetype)defaultRunLoop {
    static RunLoopTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[RunLoopTool alloc] init];
    });
    return tool;
}

- (instancetype)init {
    if ((self = [super init])) {
        _tasks = [NSMutableArray array];
        _tasksKeys = [NSMutableArray array];
        _observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting | kCFRunLoopExit, YES, LONG_MAX,^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
            [self performSelector:@selector(runLoopWorkTaskCallBack:) onThread:[NSThread mainThread] withObject:self waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
        });
    }
    return self;
}

- (void)runLoopWorkTaskCallBack:(RunLoopTool *)runLoopTool {
    if (runLoopTool.tasks.count != 0) {
        dispatch_block_t unit = runLoopTool.tasks.firstObject;
        unit();
        [runLoopTool.tasks removeObjectAtIndex:0];
        [runLoopTool.tasksKeys removeObjectAtIndex:0];
        
        if (runLoopTool.tasks.count == 0) {
            CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), _observer, kCFRunLoopCommonModes);
        }
    }
}

- (void)addTask:(dispatch_block_t)task key:(id)key {
    if (!CFRunLoopContainsObserver(CFRunLoopGetCurrent(), _observer, kCFRunLoopCommonModes)) {
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), _observer, kCFRunLoopCommonModes);
    }
    [self.tasks addObject:task];
    [self.tasksKeys addObject:key];
}

- (void)removeAllTasks {
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), _observer, kCFRunLoopCommonModes);
    [self.tasks removeAllObjects];
    [self.tasksKeys removeAllObjects];
}

//- (void)dealloc {
//    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), _observer, kCFRunLoopCommonModes);
//    CFRelease(_observer);
//}

@end
