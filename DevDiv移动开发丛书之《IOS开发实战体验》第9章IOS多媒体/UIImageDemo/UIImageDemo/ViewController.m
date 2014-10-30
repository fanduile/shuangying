//
//  ViewController.m
//  UIImageDemo
//
//  Created by Kevin Zhao on 11-12-27.
//  Copyright (c) 2011年 FH. All rights reserved.
//

#import "ViewController.h"
#import "ImageView.h"

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //加载自定义的ImageView
    ImageView *imageView  = [[ImageView alloc] initWithFrame:self.view.frame];
    
    //添加到视图
    [self.view addSubview:imageView];
    
    [imageView release];
    
}




@end
