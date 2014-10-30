//
//  EditTableViewController.m
//  RealTool
//
//  Created by Chendy on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EditTableViewController.h"
@implementation EditTableViewController
@synthesize myTableView;
@synthesize dataSource;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    [array addObject:@"A"];
    [array addObject:@"B"];
    [array addObject:@"C"];
    [array addObject:@"D"];
    [array addObject:@"E"];
    [array addObject:@"F"];
    self.dataSource = array;
    [array release];
    [myTableView setEditing:YES animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    cell.textLabel.text = [dataSource objectAtIndex:row];
    return cell;

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(IBAction)refreshData:(id)sender
{
    [myTableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)//删除单元格
    {
        [dataSource removeObjectAtIndex:indexPath.row];
        [myTableView beginUpdates];
        [myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [myTableView endUpdates];
    }
    else if(editingStyle == UITableViewCellEditingStyleInsert)//增加单元格
    {
        [dataSource insertObject:@"new Cell" atIndex:indexPath.row];
        [myTableView beginUpdates];
        [myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [myTableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath != destinationIndexPath) 
    {
        id object = [self.dataSource objectAtIndex:sourceIndexPath.row];
        [object retain];
        [self.dataSource removeObjectAtIndex:sourceIndexPath.row];
        if (destinationIndexPath.row > [self.dataSource count]) 
        {
            [self.dataSource addObject:object];
        }
        else 
        {
            [self.dataSource insertObject:object atIndex:destinationIndexPath.row];
        }
        [object release];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didEndEditingRowAtIndexPath");
}

//以下代理方法,设置在编辑状态下,哪些行是删除功能,哪些行是添加功能
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) 
    {
        return UITableViewCellEditingStyleInsert;
    }
    else 
    {
        return UITableViewCellEditingStyleDelete;
    }    
}

- (void)viewDidUnload
{
    self.myTableView = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
