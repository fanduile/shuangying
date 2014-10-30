//
//  SearchButton.m
//  SeniorGUI
//
//  Created by Chendy on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchButton.h"

@implementation SearchButton
- (void)awakeFromNib
{
	UIImage *image = [UIImage imageNamed:@"button_search_normal.png"];
    UIImage *selImage = [UIImage imageNamed: @"button_search_selected.png"];
	[self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:selImage forState:UIControlStateHighlighted];
}
@end
