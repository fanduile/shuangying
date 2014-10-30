//
//  FileContentViewController.m
//  FileBrowser
//
//  Created by Kevin Zhao on 12-1-30.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import "FileContentViewController.h"

@implementation FileContentViewController
@synthesize webView = webView_;
@synthesize path = path_;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建url
    NSURL *url = [NSURL fileURLWithPath:[self path]];
    
    //创建文件请求
    NSURLRequest *requerst = [NSURLRequest requestWithURL:url];
    
    //webView加载请求
    [webView_ loadRequest:requerst];
    
}
- (void)dealloc 
{
    [webView_ release];
    [path_ release];
    [super dealloc];
}

@end
