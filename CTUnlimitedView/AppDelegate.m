//
//  AppDelegate.m
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/2/15.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    BaseViewController *base = [[BaseViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:base];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

//    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, quene, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"%ld", i);
//        }
//    });
//    dispatch_group_async(group, quene, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"~~~~~%ld", i);
//        }
//    });
//    
//    dispatch_barrier_async(quene, ^{
//        NSLog(@"你是");
//    });
//    
//    dispatch_barrier_async(quene, ^{
//        NSLog(@"逗比");
//    });
//    
//    dispatch_async(quene, ^{
//        NSLog(@"我");
//    });
//    
//    dispatch_async(quene, ^{
//        NSLog(@"不值得");
//    });
    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"END");
//    });
    
//    dispatch_barrier_async的顺序执行依赖queue的类型，必需要queue的类型为dispatch_queue_create创建，而且attr参数值必需是DISPATCH_QUEUE_CONCURRENT类型，前面两个非dispatch_barrier_async的类型的执行是依赖其本身的执行时间
//    const char *queueName = [@"fdsg" UTF8String];
//    dispatch_queue_t queue = dispatch_queue_create(queueName, 0);
//
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"dispatch_async1");
//    });
//    dispatch_async(queue, ^{
////        [NSThread sleepForTimeInterval:1];
//        NSLog(@"dispatch_async2");
//    });
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"dispatch_barrier_async");
//        [NSThread sleepForTimeInterval:0.5];
//        
//    });
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:1];
//        NSLog(@"dispatch_async3");
//    });
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
