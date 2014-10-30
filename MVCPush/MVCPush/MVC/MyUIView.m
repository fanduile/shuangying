//
//  MyUIView.m
//  MVCPush
//
//  Created by Chendy on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyUIView.h"

@implementation MyUIView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(void)doSomething     
{         
    if(delegate != nil )  //这里的delegate就是UIView定义时候的一个委托对象         
    {             
        [delegate func1]; 
        //[]表示对一个对象发消息，如果在Java中会写成delegate.func1()         
    }     
}  

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doSomething];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
