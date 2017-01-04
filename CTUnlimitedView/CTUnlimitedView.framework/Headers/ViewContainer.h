//
//  ViewContainer.h
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "BaseContainer.h"

@interface ViewContainer : BaseContainer<ViewContainerProtocol>

@property (nonatomic, strong) UIView *view;

@end
