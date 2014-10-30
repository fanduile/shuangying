//
//  CreatDirectoryViewController.m
//  FileBrowser
//
//  Created by Kevin Zhao on 12-1-30.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import "CreatDirectoryViewController.h"
#import "RootViewController.h"

@implementation CreatDirectoryViewController
@synthesize nameField = nameField_;
@synthesize currentPath = currentPath_;
@synthesize preViewController = preViewController_;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //标题
    [self setTitle:@"新建文件夹"];
    
    //增加保存按钮及相关回调函数
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
                                target:self 
                                action:@selector(save)];
    [[self navigationItem] setRightBarButtonItem:saveItem];
    [saveItem release];

}

- (void)dealloc 
{
    [preViewController_ release];
    [currentPath_ release];
    [nameField_ release];
    [super dealloc];
}

//保存
- (void)save
{
    //获取文件夹名称
    NSString *name = [[self nameField] text];
    
    //新路径
    NSString *path = [[self currentPath] stringByAppendingPathComponent:name];
    
    //创建文件夹
    [[NSFileManager defaultManager] createDirectoryAtPath:path 
                              withIntermediateDirectories:YES
                                               attributes:nil 
                                                    error:nil];
    
    //刷新目录页面
    RootViewController *rootViewController = (RootViewController *)[self preViewController];
    [rootViewController loadFilesByDirectory:[rootViewController currentDirectoryPath]];
    [[rootViewController tableView] reloadData];
    
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
