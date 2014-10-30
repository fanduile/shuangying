//
//  CreatFileViewController.m
//  FileBrowser
//
//  Created by Kevin on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreatFileViewController.h"
#import "RootViewController.h"

@implementation CreatFileViewController
@synthesize nameField = nameField_;
@synthesize textView = textView_;
@synthesize currentPath = currentPath_;
@synthesize preViewController = preViewController_;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //标题
    [self setTitle:@"新建文件"];
    
    //增加保存按钮及相关回调函数
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] 
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
                                 target:self 
                                 action:@selector(save)];
    [[self navigationItem] setRightBarButtonItem:saveItem];
    [saveItem release];
}


//保存
- (void)save
{
    //获取文件夹名称
    NSString *name = [[self nameField] text];
    
    //新路径
    NSString *path = [[self currentPath] stringByAppendingPathComponent:name];
    
    //获取文件数据
    NSData *data = [[[self textView] text] dataUsingEncoding:NSUTF8StringEncoding];
    
    //写文件
    [data writeToFile:path atomically:YES];
    
    //刷新目录页面
    RootViewController *rootViewController = (RootViewController *)[self preViewController];
    [rootViewController loadFilesByDirectory:[rootViewController currentDirectoryPath]];
    [[rootViewController tableView] reloadData];
    
    
    [[self navigationController] popViewControllerAnimated:YES];
}



@end
