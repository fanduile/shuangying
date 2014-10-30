//
//  BubbleTableController.m
//  TableShow
//
//  Created by Chendy on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BubbleTableController.h"

@implementation BubbleTableController
@synthesize bubbleTable = bubbleTable_;
@synthesize dataSource = dataSource_;
@synthesize msgTextField = msgTextField_;

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
    self.title = @"气泡表格";
    msgTextField_.enablesReturnKeyAutomatically = YES;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" 
                                                                               style:UIBarButtonItemStyleBordered 
                                                                              target:self
                                                                              action:@selector(hideKeyboard)] autorelease];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    self.dataSource = array;
    [array release];
    msgFrom = YES;//刚开始是YES,即第一条信息是自己发送，放在右边，绿色气泡
}

-(void)hideKeyboard
{
    if([msgTextField_ isFirstResponder])
    {
        [msgTextField_ resignFirstResponder];
    }
    NSTimeInterval animationDuration = 0.30f;        
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];        
    [UIView setAnimationDuration:animationDuration];        
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);        
    self.view.frame = rect;        
    [UIView commitAnimations]; 
}

//处理键盘弹出时会遮盖单行输入框的问题，将视图上移
- (void)textFieldDidBeginEditing:(UITextField *)textField
{        
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 246.0);//
    NSTimeInterval animationDuration = 0.30f;                
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];                
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;                
    float height = self.view.frame.size.height;        
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);                
        self.view.frame = rect;        
    }        
    [UIView commitAnimations];                
}

//点发送回车时，根据信息内容创建气泡视图，并添加到表格视图的数据源中。
- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    NSTimeInterval animationDuration = 0.30f;        
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];        
    [UIView setAnimationDuration:animationDuration];        
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);        
    self.view.frame = rect;        
    [UIView commitAnimations];        
    [textField resignFirstResponder];

	UIView *chatView = [self getBubble:[NSString stringWithFormat:@"%@: %@", msgFrom?@"我":@"张三", textField.text] from:msgFrom];
	[dataSource_ addObject:[NSDictionary dictionaryWithObjectsAndKeys:textField.text, @"text", msgFrom ? @"self":@"other", @"speaker", chatView,@"bubbleView", nil]];
	msgFrom = !msgFrom;
	[bubbleTable_ reloadData];
	[bubbleTable_ scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[dataSource_ count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
	textField.text = @"";
	return YES;
}

//根据信息内容和信息是由谁发送创建气泡视图
- (UIView *)getBubble:(NSString *)bubbleText from:(BOOL)isSelf 
{
	UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
	bgView.backgroundColor = [UIColor clearColor];
	UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:isSelf?@"bubble_right":@"bubble_left" ofType:@"png"]];
	UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
	UIFont *font = [UIFont systemFontOfSize:12];
	CGSize size = [bubbleText sizeWithFont:font constrainedToSize:CGSizeMake(150.0f, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
	UILabel *bubbleTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(21.0f, 14.0f, size.width+10, size.height+10)];
	bubbleTextLabel.backgroundColor = [UIColor clearColor];
	bubbleTextLabel.font = font;
	bubbleTextLabel.numberOfLines = 0;
	bubbleTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
	bubbleTextLabel.text = bubbleText;
	bubbleImageView.frame = CGRectMake(0.0f, 0.0f, 200.0f, size.height+40.0f);
	if(isSelf)
    {
		bgView.frame = CGRectMake(120.0f, 10.0f, 200.0f, size.height+50.0f);
    }
	else
    {
		bgView.frame = CGRectMake(0.0f, 10.0f, 200.0f, size.height+50.0f);
	}
	[bgView addSubview:bubbleImageView];
	[bubbleImageView release];
	[bgView addSubview:bubbleTextLabel];
	[bubbleTextLabel release];
	return [bgView autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [dataSource_ count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UIView *chatView = [[dataSource_ objectAtIndex:[indexPath row]] objectForKey:@"bubbleView"];
	return chatView.frame.size.height+10.0f;
}

// 创建单元格，增加气泡视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	NSDictionary *chatInfo = [dataSource_ objectAtIndex:[indexPath row]];
	for(UIView *subview in [cell.contentView subviews])
		[subview removeFromSuperview];
	[cell.contentView addSubview:[chatInfo objectForKey:@"bubbleView"]];
    return cell;
}

- (void)viewDidUnload
{
    self.bubbleTable = nil;
    self.msgTextField = nil;
    [super viewDidUnload];
}

-(void)dealloc
{
    [self.bubbleTable release];
    [self.msgTextField release];
    [self.dataSource release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
