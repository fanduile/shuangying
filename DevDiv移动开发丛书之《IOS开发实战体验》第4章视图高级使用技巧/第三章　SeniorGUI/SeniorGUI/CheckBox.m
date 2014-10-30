//
//  CheckBox.m
//  SeniorGUI
//
//  Created by Chendy on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CheckBox.h"

@implementation CheckBox
@synthesize isChecked;
- (void)awakeFromNib
{
	UIImage *image = [[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"uncheck.png"]] stretchableImageWithLeftCapWidth:6.0 topCapHeight:0.0];
	[self setBackgroundImage:image forState:UIControlStateNormal];
    isChecked = false;
    [self addTarget:self action:@selector(setChecked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setChecked
{
    isChecked = !isChecked;
    if(isChecked)
    {
        [self setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateHighlighted];
    }
    
}

@end
