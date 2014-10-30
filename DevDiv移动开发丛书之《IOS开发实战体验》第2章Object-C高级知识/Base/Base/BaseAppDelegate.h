//
//  BaseAppDelegate.h
//  Base
//
//  Created by Chendy on 11-12-6.
//  Copyright (c) 2011年 睿拓(RealTool)工作室(realtool@163.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseViewController;

@interface BaseAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BaseViewController *viewController;

@end
