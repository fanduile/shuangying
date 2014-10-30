//
//  ViewController.h
//  NSURLRequest
//
//  Created by Kevin Zhao on 11-12-8.
//  Copyright (c) 2011年 FH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate>
{
    //图片地址输入框
    UITextField *imagePathField_;

    //用于显示图片的ImageView
    UIImageView *imageView_;

}

@property(nonatomic, retain)IBOutlet UITextField *imagePathField;
@property(nonatomic, retain)IBOutlet UIImageView *imageView;

//触发网络连接
- (IBAction)doConnect:(id)sender;


@end
