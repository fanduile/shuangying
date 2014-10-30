//
//  ViewController.m
//  ImagePicker
//
//  Created by Kevin Zhao on 12-1-31.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize imageView = imageView_;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

//获取图片
- (IBAction)pickPhoto:(id)sender
{
    //创建图像选取器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setDelegate:self];
    
    //显示图像选取器
    [self presentModalViewController:imagePickerController animated:YES];

}

//选取图片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //将获取到的Image加载到对应的UIImageView
    [[self imageView] setImage:image];
    
    //隐藏视图
    [picker dismissModalViewControllerAnimated:YES];
}

//取消选取图片后的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //隐藏视图
    [picker dismissModalViewControllerAnimated:YES];
}

@end
