//
//  RootViewController.h
//  FileBrowser
//
//  Created by Kevin on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController<UIActionSheetDelegate>
{
    //当前目录包含文件
    NSArray *directoryArray_;
    
    //当前路径
    NSString *currentDirectoryPath_;
}

@property(nonatomic, retain)NSArray *directoryArray;
@property(nonatomic, retain)NSString *currentDirectoryPath;

//加载目录下文件
- (void)loadFilesByDirectory:(NSString *)directory;

//创建文件目录
- (void)creatDirectory;

//创建文件
- (void)creatFile;

//创建文件或者文件目录的回调函数
- (void)creat;



@end
