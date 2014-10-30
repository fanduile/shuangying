//
//  ViewController.h
//  ImagePicker
//
//  Created by Kevin Zhao on 12-1-31.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    //用于显示图片的UIImageView
    UIImageView *imageView_;
}

@property(nonatomic, retain)IBOutlet UIImageView *imageView;


//获取图片
- (IBAction)pickPhoto:(id)sender;


@end
