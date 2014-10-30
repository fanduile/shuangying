//
//  MultiThreadMasterViewController.m
//  MyMultiThread
//
//  Created by  on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MultiThreadMasterViewController.h"
#import "OriginThreadController.h"
#import "MultiThreadDetailViewController.h"
#import "NSThreadController.h"
#import "NSOperationController.h"

@implementation MultiThreadMasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"线程类型";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell.
    NSInteger row = indexPath.row;
    if(row == 0)
    {
        
        cell.textLabel.text = @"unix下的多线程";
    }
    else if(row == 1)
    {
        cell.textLabel.text = @"NSThread多线程";
    }
    else if(row == 2)
    {
        cell.textLabel.text = @"线程池NSOperationQueue";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if(row == 0)
    {
        OriginThreadController*vc = [[OriginThreadController alloc] initWithNibName:@"OriginThreadController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 1)
    {
        NSThreadController*vc = [[NSThreadController alloc] initWithNibName:@"NSThreadController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 2)
    {
        NSOperationController*vc = [[NSOperationController alloc] initWithNibName:@"NSOperationController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}

@end
