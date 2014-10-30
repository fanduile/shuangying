//
//  DragMoreTableController.m
//  TableShow
//
//  Created by Chendy on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DragMoreTableController.h"
#import "LoadFootView.h"

@implementation DragMoreTableController
@synthesize table = table_;
@synthesize dataArray = dataArray_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
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
    self.title = @"向上拖动显示更多";
    index = 0;
    NSArray* viewArray = [[NSBundle mainBundle] loadNibNamed:@"LoadFootView" owner:nil options:nil];
    loadView = [[viewArray objectAtIndex:0] retain];
    table_.tableFooterView = loadView;
    loadView.tipView.text = [[NSString alloc] initWithString:MORE_STRING];
    NSMutableArray* array = [[NSMutableArray alloc] initWithObjects:@"表格数据", @"表格数据", @"表格数据", nil];
    self.dataArray = array;
    [array release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(dataArray_ != nil)
    {
        int count = [dataArray_ count];
        return count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
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
    cell.imageView.image = [UIImage imageNamed:@"share_this_icon.png"];
    cell.textLabel.text = [dataArray_ objectAtIndex:indexPath.row];
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate 
{
    if (loadView.isLoading) 
    {
		return ;
	}
    CGSize contentSize = scrollView.contentSize;
    CGRect frame = scrollView.frame;
    CGPoint contentPos = scrollView.contentOffset;
	if (contentPos.y > contentSize.height - frame.size.height) 
    {
        [loadView startLoading];
        //刷新请求更多数据
        [self performSelector:@selector(getMoreData) withObject:nil afterDelay:3];
    }
}

-(void)getMoreData
{
    index ++;
    NSString* str = [NSString stringWithFormat:@"第%d次请求的新数据", index];
    [dataArray_ addObject:str];
    [dataArray_ addObject:str];
    [self reloadTable];
}

- (void)reloadTable
{
    [loadView stopLoading];
    [self.table reloadData];
    loadView.tipView.text = [[NSString alloc] initWithString:MORE_STRING];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
