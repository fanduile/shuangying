//
//  FileInfomationViewController.h
//  FileBrowser
//
//  Created by Kevin Zhao on 12-1-30.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileInfomationViewController : UIViewController
{
    //文件路径
    NSString *filePath_;
    
    //文件名
    UILabel *nameLabel_;
    
    //文件大小
    UILabel *fileSizeLabel_;
    
    //文件创建日期
    UILabel *fileCreateDate_;
}

@property(nonatomic, retain)NSString *filePath;
@property(nonatomic, retain)IBOutlet UILabel *nameLabel;
@property(nonatomic, retain)IBOutlet UILabel *fileSizeLabel;
@property(nonatomic, retain)IBOutlet UILabel *fileCreateDate;

//浏览文件
- (IBAction)readFile:(id)sender;


@end
