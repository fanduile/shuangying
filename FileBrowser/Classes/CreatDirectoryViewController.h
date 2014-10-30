//
//  CreatDirectoryViewController.h
//  FileBrowser
//
//  Created by Kevin Zhao on 12-1-30.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatDirectoryViewController : UIViewController
{

    //用于输入文件夹名的输入框
    UITextField *nameField_;
    
    //当前文件路径
    NSString *currentPath_;
    
    //前一页面
    UIViewController *preViewController_;
}

@property(nonatomic, retain)IBOutlet UITextField *nameField;
@property(nonatomic, retain)NSString *currentPath;
@property(nonatomic, retain)UIViewController *preViewController;

//保存
- (void)save;


@end
