//
//  HardwareCommViewController.m
//  HardwareComm
//
//  Created by Chendy on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HardwareCommViewController.h"
#import "CameraViewController.h"
#import "AccelerometerViewController.h"
#import "CoreMotionViewController.h"
#import "GatherViewController.h"
#import "CommViewController.h"

@implementation HardwareCommViewController
@synthesize table;
@synthesize array;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* dataArray = [[NSArray alloc] initWithObjects:@"摄像头", @"加速计", @"陀螺仪", @"通讯录", @"通信相关", nil];
    self.array = dataArray;
    [dataArray release];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    //建立可重用单元标识
    UITableViewCell* cell = nil;
    //获取分组
    if (cell == nil) 
    {
        cell=[[[UITableViewCell alloc] 
               initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil]autorelease];
    }
    cell.textLabel.text = [self.array objectAtIndex:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if(row == 0)
    {
        CameraViewController* vc = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 1)
    {
        AccelerometerViewController* vc = [[AccelerometerViewController alloc] initWithNibName:@"AccelerometerViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 2)
    {
        CoreMotionViewController* vc = [[CoreMotionViewController alloc] initWithNibName:@"CoreMotionViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 3)
    {
        GatherViewController* vc = [[GatherViewController alloc] initWithNibName:@"GatherViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 4)
    {
        CommViewController* vc = [[CommViewController alloc] initWithNibName:@"CommViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
