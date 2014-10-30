//
//  MyUIView.h
//  MVCPush
//
//  Created by Chendy on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUIViewDelegate.h"

@interface MyUIView : UIView
{
    id<MyUIViewDelegate>delegate;
}
//定义一些控件设置方法     
@property(nonatomic, assign) id<MyUIViewDelegate>delegate; //定义一个属性，可以用来进行get set操作  
-(void)doSomething;

@end
