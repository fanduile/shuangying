//
//  CreatFileViewController.h
//  FileBrowser
//
//  Created by Kevin on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatFileViewController : UIViewController
{
    //文件名输入框
    UITextField *nameField_;
    
    //文件内容输入框
    UITextView *textView_;
    
    //当前文件路径
    NSString *currentPath_;
    
    //前一页面
    UIViewController *preViewController_;
}

@property(nonatomic, retain)IBOutlet UITextField *nameField;
@property(nonatomic, retain)IBOutlet UITextView *textView;
@property(nonatomic, retain)NSString *currentPath;
@property(nonatomic, retain)UIViewController *preViewController;

//保存
- (void)save;

@end
