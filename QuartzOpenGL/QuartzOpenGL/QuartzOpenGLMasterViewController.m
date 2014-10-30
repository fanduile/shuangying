//
//  QuartzOpenGLMasterViewController.m
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuartzOpenGLMasterViewController.h"

#import "QuartzOpenGLDetailViewController.h"
#import "QuartzBaseController.h"
#import "OpenGLBaseController.h"
#import "QuartzEditController.h"
#import "QuartzShadowController.h"
#import "QuartzGradientController.h"
#import "QuartzPDFController.h"
#import "QuartzPictureController.h"


@implementation QuartzOpenGLMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize dataSource = dataSource_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = NSLocalizedString(@"iPhone绘图应用", @"iPhone绘图应用");
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [dataSource_ release];
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
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:4];
    NSArray* array1 = [[NSArray alloc] initWithObjects:@"Quartz 图形展示", @"Quartz 阴影展示", @"Quartz 剪切展示",@"Quartz 渐变展示",@"Quartz 图片展示",@"Quartz PDF展示", nil];
    NSArray* array2 = [[NSArray alloc] initWithObjects:@"OpenGL ES 展示", nil];
    [array addObject:array1];
    [array addObject:array2];
    [array1 release];
    [array2 release];
    self.dataSource = array;
    [array release];
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
    return [self.dataSource count];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
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
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    // Configure the cell.
    cell.textLabel.text = [[self.dataSource objectAtIndex:section]objectAtIndex:row];//NSLocalizedString(@"Detail", @"Detail");
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (!self.detailViewController) {
//        self.detailViewController = [[[QuartzOpenGLDetailViewController alloc] initWithNibName:@"QuartzOpenGLDetailViewController" bundle:nil] autorelease];
//    }
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    if(section == 0)
    {
        if(row == 0)
        {
            QuartzBaseController* vc = [[QuartzBaseController alloc] initWithNibName:@"QuartzBaseController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        else if(row == 1)
        {
            QuartzShadowController* vc = [[QuartzShadowController alloc] initWithNibName:@"QuartzShadowController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        else if(row == 2)
        {
            QuartzEditController* vc = [[QuartzEditController alloc] initWithNibName:@"QuartzEditController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        else if(row == 3)
        {
            QuartzGradientController* vc = [[QuartzGradientController alloc] initWithNibName:@"QuartzGradientController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        else if(row == 4)
        {
            QuartzPictureController* vc = [[QuartzPictureController alloc] initWithNibName:@"QuartzPictureController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        else if(row == 5)
        {
            QuartzPDFController* vc = [[QuartzPDFController alloc] initWithNibName:@"QuartzPDFController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
    }
    else if(section == 1)
    {
        if(row == 0)
        {
            OpenGLBaseController* vc = [[OpenGLBaseController alloc] initWithNibName:@"OpenGLBaseController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
    }
}






@end
