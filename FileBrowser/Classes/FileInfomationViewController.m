//
//  FileInfomationViewController.m
//  FileBrowser
//
//  Created by Kevin Zhao on 12-1-30.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import "FileInfomationViewController.h"
#import "FileContentViewController.h"



@implementation FileInfomationViewController
@synthesize filePath = filePath_;
@synthesize nameLabel = nameLabel_;
@synthesize fileSizeLabel = fileSizeLabel_;
@synthesize fileCreateDate = fileCreateDate_;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //文件名称
    [[self nameLabel] setText:[[self filePath] lastPathComponent]];
    
    //加载信息
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath_ error:nil];
    
    //日期
    NSDate *createDate = [attributes objectForKey:NSFileCreationDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [[self fileCreateDate] setText:[dateFormatter stringFromDate:createDate]];
    [dateFormatter release];
    
    //大小
    NSNumber *fileSize = (NSNumber *)[attributes objectForKey:NSFileSize];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"#,##0.## bytes"];
    [[self fileSizeLabel] setText:[numberFormatter stringFromNumber:fileSize]];
    [numberFormatter release];
}

- (void)dealloc
{
    [filePath_ release];
    [super dealloc];
}

//浏览文件
- (IBAction)readFile:(id)sender
{
    FileContentViewController *fileContentViewController  = [[FileContentViewController alloc] initWithNibName:@"FileContentViewController" bundle:nil];
    
    [fileContentViewController setPath:[self filePath]];
    
    [[self navigationController] pushViewController:fileContentViewController animated:YES];
    [fileContentViewController release];
    
}


@end
