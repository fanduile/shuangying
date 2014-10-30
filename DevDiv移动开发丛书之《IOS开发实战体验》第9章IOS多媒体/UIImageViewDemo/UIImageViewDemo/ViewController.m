//
//  ViewController.m
//  UIImageViewDemo
//
//  Created by Kevin Zhao on 11-12-27.
//  Copyright (c) 2011年 FH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //初始化UIImageView
    CGRect viewFrame = CGRectMake(110, 100, 100, 100);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:viewFrame];
    
    //加载图像
    UIImage *step1 = [UIImage imageNamed:@"loading1.png"];
    UIImage *step2 = [UIImage imageNamed:@"loading2.png"];
    UIImage *step3 = [UIImage imageNamed:@"loading3.png"];
    UIImage *step4 = [UIImage imageNamed:@"loading4.png"];
    UIImage *step5 = [UIImage imageNamed:@"loading5.png"];
    UIImage *step6 = [UIImage imageNamed:@"loading6.png"];
    UIImage *step7 = [UIImage imageNamed:@"loading7.png"];
    UIImage *step8 = [UIImage imageNamed:@"loading8.png"];
    NSArray *imageArray = [NSArray arrayWithObjects:
                           step1, step2, step3, step4,
                           step5, step6, step7, step8,
                           nil];
    [imageView setAnimationImages:imageArray];
    
    //设置动画参数
    [imageView setAnimationDuration:0.7];
    [imageView startAnimating];
    
    //添加到当前视图
    [self.view addSubview:imageView];
    [imageView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
