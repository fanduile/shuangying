//
//  LoadFootView.m
//  RabitRun
//
//  Created by Chendy wang on 11-12-18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoadFootView.h"
@implementation LoadFootView
@synthesize tipView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib
{
    activeView.hidesWhenStopped = YES;
}
- (void)startLoading
{
    [activeView startAnimating];
    tipView.text = NSLocalizedString(@"正在加载...",nil);
}
- (void)stopLoading
{
    [activeView stopAnimating];
}
- (BOOL)isLoading
{
    return [activeView isAnimating];
}
@end
