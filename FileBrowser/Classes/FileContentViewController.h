//
//  FileContentViewController.h
//  FileBrowser
//
//  Created by Kevin Zhao on 12-1-30.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileContentViewController : UIViewController
{
    //用于浏览文件的UIWebView
    UIWebView *webView_;
    
    //文件路径
    NSString *path_;

}

@property(nonatomic, retain)IBOutlet UIWebView *webView;
@property(nonatomic, retain)NSString *path;


@end
