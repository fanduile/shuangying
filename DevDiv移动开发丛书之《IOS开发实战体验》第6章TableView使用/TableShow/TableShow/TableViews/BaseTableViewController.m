//
//  BaseTableViewController.m
//  TableShow
//
//  Created by Chendy on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
@synthesize table = table_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    //cell.textLabel.text =@"系统样式的表格单元格";
    //cell.imageView.image = [UIImage imageNamed:@"share_this_icon.png"];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
    label.text = @"通过代码添加的Label";
    [[cell contentView]addSubview:label];
    [label release];
    UISwitch* swi = [[UISwitch alloc] initWithFrame:CGRectMake(210, 15, 30, 20)];
    swi.on = YES;
    [[cell contentView] addSubview:swi];
    [swi release];
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
