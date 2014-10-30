//
//  LoadFootView.m
//  RabitRun
//
//  Created by Chendy wang on 11-12-18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MORE_STRING  NSLocalizedString(@"向上拖动显示更多",@"向上拖动显示更多")
#define NO_MORE_STRING NSLocalizedString(@"已经到达列表底部",@"已经到达列表底部")

@interface LoadFootView : UIView
{
    IBOutlet UIActivityIndicatorView* activeView;
    IBOutlet UILabel* tipView;
}
@property(nonatomic,readonly) BOOL isLoading;
@property(nonatomic,readonly) UILabel* tipView;
- (void)startLoading;
- (void)stopLoading;
@end
