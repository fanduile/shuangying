//
//  TableShowMasterViewController.m
//  TableShow
//
//  Created by Chendy on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableShowMasterViewController.h"
#import "CustomTableCellController.h"
#import "BaseTableViewController.h"
#import "EditTableViewController.h"
#import "BubbleTableController.h"
#import "DragMoreTableController.h"

@implementation TableShowMasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =@"表格视图";
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
    return 5;
}

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
    switch (row) 
    {
        case 0:
        {
            cell.textLabel.text =@"表格视图--普通表格";
            break;
        }
        case 1:
        {
            cell.textLabel.text =@"表格视图--定制表格";
            break;
        }
        case 2:
        {
            cell.textLabel.text =@"表格视图--编辑表格";
            break;
        }
        case 3:
        {
            cell.textLabel.text =@"表格视图--气泡表格";
            break;
        }
        case 4:
        {
            cell.textLabel.text =@"表格视图--拖动显示更多";
            break;
        }
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)] autorelease];
    label.text = @"表段头";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor lightGrayColor];
    return label;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel* label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)] autorelease];
    label.text = @"表段底";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor darkGrayColor];
    return label;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if(row == 0)
    {
        if (!self.detailViewController) 
        {
            self.detailViewController = [[[BaseTableViewController alloc] initWithNibName:@"BaseTableViewController" bundle:nil] autorelease];
        }
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
    else if(row == 1)
    {
        CustomTableCellController* vc = [[CustomTableCellController alloc] initWithNibName:@"CustomTableCellController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 2)
    {
        EditTableViewController* vc = [[EditTableViewController alloc] initWithNibName:@"EditTableViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 3)
    {
        BubbleTableController* vc = [[BubbleTableController alloc] initWithNibName:@"BubbleTableController" bundle:nil];
        [self.navigationController pushViewController:vc animated:nil];
        [vc release];
    }
    else if(row == 4)
    {
        DragMoreTableController* vc = [[DragMoreTableController alloc] initWithNibName:@"DragMoreTableController" bundle:nil];
        [self.navigationController pushViewController:vc animated:nil];
        [vc release];
    }

}

@end
