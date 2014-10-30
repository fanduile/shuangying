//
//  PlistController.m
//  Database
//
//  Created by  on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlistController.h"

@interface PlistController ()

@end

@implementation PlistController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Plist文件";
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)readBundlePlist:(id)sender
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];   
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSLog(@"plistContent=%@",[dictionary description]);
}
-(IBAction)createPlist:(id)sender
{
    //创建数据
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:10];
    [dic setObject:@"RealTool Studio" forKey:@"organizer"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"age"];
    [dic setObject:[NSArray arrayWithObjects:@"ChenDongyan" , @"ZhangDawei" , @"ChenDongchao", nil] forKey:@"members"];
    [dic setObject:[NSNumber numberWithBool:YES] forKey:@"isReady"];
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory , NSUserDomainMask , YES );
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* plistPath = [NSString stringWithFormat:@"%@/createdPlist.plist", documentsDirectory];
    [dic writeToFile:plistPath atomically:YES];
}

-(IBAction)readDocumentPlist:(id)sender
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory , NSUserDomainMask , YES );
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* plistPath = [NSString stringWithFormat:@"%@/createdPlist.plist", documentsDirectory];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSLog(@"createdPlist=%@", [dic description]);
}

-(IBAction)editPlist:(id)sender
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory , NSUserDomainMask , YES );
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* plistPath = [NSString stringWithFormat:@"%@/createdPlist.plist", documentsDirectory];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    [dic setObject:[NSNumber numberWithInt:100] forKey:@"age"];
    [dic writeToFile:plistPath atomically:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
