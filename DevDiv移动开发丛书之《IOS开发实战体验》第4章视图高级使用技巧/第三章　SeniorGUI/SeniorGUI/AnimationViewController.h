//
//  AnimationViewController.h
//  SeniorGUI
//
//  Created by Chendy on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationViewController : UIViewController
{
    UIView* firstView;
    UIView* sndView;
    UIView* thirdView;
    UIView* fourthView;
    UIScrollView* bgView;
    bool isAni;
}

@property(nonatomic, retain) UIView* firstView;
@property(nonatomic, retain) UIView* sndView;
@property(nonatomic, retain) UIView* thirdView;
@property(nonatomic, retain) UIView* fourthView;
@property(nonatomic, retain) UIScrollView* bgView;

-(IBAction)animationControl:(id)sender;

@end
