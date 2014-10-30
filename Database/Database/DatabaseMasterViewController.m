//
//  DatabaseMasterViewController.m
//  Database
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DatabaseMasterViewController.h"

#import "DatabaseDetailViewController.h"
#import "CoreDataController.h"
#import "PlistController.h"
#import "NSDefaultController.h"
#import "SqliteController.h"


@implementation DatabaseMasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = @"数据持久化";
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
    return 4;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSInteger row = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell.
    if(row == 0)
    {
        cell.textLabel.text = @"Plist文件操作";
    }
    else if(row == 1)
    {
        cell.textLabel.text =@"NSUserDefault操作";
    }
    else if(row == 2)
    {
        cell.textLabel.text = @"Sqlite数据库操作";
    }
    else if(row == 3)
    {
        cell.textLabel.text =@"CoreData文件操作";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if(row == 0)
    {
        PlistController* vc = [[PlistController alloc] initWithNibName:@"PlistController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 1)
    {
        NSDefaultController* vc = [[NSDefaultController alloc] initWithNibName:@"NSDefaultController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 2)
    {
        SqliteController* vc = [[SqliteController alloc] initWithNibName:@"SqliteController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 3)
    {
        CoreDataController* vc = [[CoreDataController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 4)
    {
        
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
