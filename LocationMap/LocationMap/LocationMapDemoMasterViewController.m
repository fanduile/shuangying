//
//  LocationMapDemoMasterViewController.m
//  LocationMap
//
//  Created by Chendy on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "LocationMapDemoMasterViewController.h"
#import "AnnotationViewController.h"
#import "BaseMapViewController.h"
#import "CoreLocationViewController.h"
#import "DrawMapViewController.h"

@implementation LocationMapDemoMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize dataArray = dataArray_;

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
    NSArray* array = [NSArray arrayWithObjects:@"CoreLocation demo", @"Base mapView demo",@"Draw Line on map demo" , nil];
    self.dataArray = array;
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
    return [dataArray_ count];
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
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];//NSLocalizedString(@"Detail", @"Detail");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (!self.detailViewController) 
//    {
//        self.detailViewController = [[[LocationMapDemoDetailViewController alloc] initWithNibName:@"LocationMapDemoDetailViewController" bundle:nil] autorelease];
//    }
    NSInteger row = indexPath.row;
    if(row == 0)
    {
        CoreLocationViewController* vc = [[CoreLocationViewController alloc] initWithNibName:@"CoreLocationViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 1)
    {
        BaseMapViewController* vc = [[BaseMapViewController alloc] initWithNibName:@"BaseMapViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    else if(row == 2)
    {
        DrawMapViewController* vc = [[DrawMapViewController alloc] initWithNibName:@"DrawMapViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}

@end
