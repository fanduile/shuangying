//
//  RootViewController.m
//  FileBrowser
//
//  Created by Kevin on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "FileInfomationViewController.h"
#import "CreatDirectoryViewController.h"
#import "CreatFileViewController.h"

@implementation RootViewController

@synthesize directoryArray = directoryArray_;
@synthesize currentDirectoryPath = currentDirectoryPath_;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    //加载目录下文件
    [self loadFilesByDirectory:[self currentDirectoryPath]];
    
    //增加添加按钮及相关回调函数
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                target:self 
                                action:@selector(creat)];
    [[self navigationItem] setRightBarButtonItem:addItem];
    [addItem release];
    
}

//加载目录下文件
- (void)loadFilesByDirectory:(NSString *)directory
{
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:nil];
    [self setDirectoryArray:files];
}


//创建文件目录
- (void)creatDirectory
{
    //判断当前目录是否可写
    BOOL isDirectoryCanWrite = [[NSFileManager defaultManager] isWritableFileAtPath:[self currentDirectoryPath]];
    
    if (isDirectoryCanWrite) 
    {
        CreatDirectoryViewController *creatDirectoryViewController = [[CreatDirectoryViewController alloc] initWithNibName:@"CreatDirectoryViewController" bundle:nil];
        [creatDirectoryViewController setCurrentPath:[self currentDirectoryPath]];
        [creatDirectoryViewController setPreViewController:self];
        [[self navigationController] pushViewController:creatDirectoryViewController animated:YES];
        
        [creatDirectoryViewController release];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] 
                                  initWithTitle:@"" 
                                  message:@"当前目录不可写" 
                                  delegate:nil 
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil, 
                                  nil];
        [alertView show];
        [alertView release];
    
    }
}

//创建文件
- (void)creatFile
{
    //判断当前目录是否可写
    BOOL isDirectoryCanWrite = [[NSFileManager defaultManager] isWritableFileAtPath:[self currentDirectoryPath]];
    
    if (isDirectoryCanWrite) 
    {
        CreatFileViewController *creatFileViewController = [[CreatFileViewController alloc] initWithNibName:@"CreatFileViewController" bundle:nil];
        [creatFileViewController setCurrentPath:[self currentDirectoryPath]];
        [creatFileViewController setPreViewController:self];
        [[self navigationController] pushViewController:creatFileViewController animated:YES];
        
        [creatFileViewController release];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] 
                                  initWithTitle:@"" 
                                  message:@"当前目录不可写" 
                                  delegate:nil 
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil, 
                                  nil];
        [alertView show];
        [alertView release];
        
    }
}

//创建文件或者文件目录的回调函数
- (void)creat
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] 
                                  initWithTitle:@"请选择" 
                                  delegate:self
                                  cancelButtonTitle:@"取消" 
                                  destructiveButtonTitle:nil 
                                  otherButtonTitles:@"创建文件", @"创建文件夹", nil];

    [actionSheet showInView:self.view];
    [actionSheet release];
}

//点击UIActionSheet后的回调函数
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) 
    {
        //创建文件
        [self creatFile];
    }
    else if(buttonIndex == 1)
    {
        //创建文件夹
        [self creatDirectory];
    }
}



#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [[self directoryArray] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //获取文件名
    NSString *name = [[self directoryArray] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:name];
    
    //拼接路径
    NSString *path = [[self currentDirectoryPath] stringByAppendingPathComponent:name];
    
    //判断是否是文件夹
    BOOL isDirectory;
    
    //判断是文件还是文件夹来显示不同的图标
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory) 
    {
        [[cell imageView] setImage:[UIImage imageNamed:@"dir.png"]];
    }
    else
    {
        [[cell imageView] setImage:[UIImage imageNamed:@"other.png"]];
    }
        
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //获取点击文件名
    NSString *name = [[self directoryArray] objectAtIndex:[indexPath row]];
    
    //拼接路径
    NSString *path = [[self currentDirectoryPath] stringByAppendingPathComponent:name];
    
    //判断是否是文件夹
    BOOL isDirectory;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory) 
    {
        //如果是文件夹则依旧显示文件目录
        RootViewController *detailViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
        [detailViewController setCurrentDirectoryPath:path];
        
        //标题
        [detailViewController setTitle:name];
        
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
    else
    {
        //如果是文件则显示文件详细内容
        FileInfomationViewController *fileInfomationViewController = [[FileInfomationViewController alloc] initWithNibName:@"FileInfomationViewController" bundle:nil];
        [fileInfomationViewController setFilePath:path];
        
        //标题
        [fileInfomationViewController setTitle:name];
        
        [self.navigationController pushViewController:fileInfomationViewController animated:YES];
        [fileInfomationViewController release];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除手势
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        //获取点击文件名
        NSString *name = [[self directoryArray] objectAtIndex:[indexPath row]];
        
        //拼接路径
        NSString *path = [[self currentDirectoryPath] stringByAppendingPathComponent:name];
        
        //判断当前目录是否可写
        BOOL isDirectoryCanWrite = [[NSFileManager defaultManager] isWritableFileAtPath:path];
        
        if (isDirectoryCanWrite) 
        {
            //删除
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            
            //刷新
            [self loadFilesByDirectory:[self currentDirectoryPath]];
            [[self tableView] reloadData];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] 
                                      initWithTitle:@"" 
                                      message:@"没有权限删除！" 
                                      delegate:nil 
                                      cancelButtonTitle:@"确定" 
                                      otherButtonTitles:nil, 
                                      nil];
            [alertView show];
            [alertView release];
            
        }
    }
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{
    [directoryArray_ release];
    [currentDirectoryPath_ release];
    [super dealloc];
}


@end

