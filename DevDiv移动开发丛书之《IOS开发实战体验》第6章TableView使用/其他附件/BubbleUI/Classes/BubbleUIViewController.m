//
//  BubbleUIViewController.m
//  BubbleUI
//
//  Created by Wei-Meng Lee on 4/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BubbleUIViewController.h"

@implementation BubbleUIViewController

@synthesize itemName;
@synthesize tableView;

NSMutableArray *listOfMessages;
NSMutableArray *dateOfMessages;

static CGFloat const  kAccountDetailFontSize = 14.0;
static int const DATELABEL_TAG = 1;
static int const MESSAGELABEL_TAG = 2;
static int const IMAGEVIEW_TAG_1 = 3;
static int const IMAGEVIEW_TAG_2 = 4;
static int const IMAGEVIEW_TAG_3 = 5;
static int const IMAGEVIEW_TAG_4 = 6;
static int const IMAGEVIEW_TAG_5 = 7;
static int const IMAGEVIEW_TAG_6 = 8;
static int const IMAGEVIEW_TAG_7 = 9;
static int const IMAGEVIEW_TAG_8 = 10;
static int const IMAGEVIEW_TAG_9 = 11;

int bubbleFragment_width, bubbleFragment_height;
int bubble_width;
int bubble_x, bubble_y;

-(IBAction) doneEditing:(id) sender {
	[sender resignFirstResponder];
}

- (void)viewDidLoad {
	//---location to display the bubble fragment--- 
	bubble_x = 10;
	bubble_y = 20;
	
	//---size of the bubble fragment---
	bubbleFragment_width = 56;
	bubbleFragment_height = 32;
	
	//---width of the bubble---
//	bubble_width = 300;
	
	//---contains the messages---
	listOfMessages = [[NSMutableArray alloc] init];
	//---contains the date for each message---
	dateOfMessages = [[NSMutableArray alloc] init];	
	
	//---add items---
	[listOfMessages addObject:@"表格第一行!"];
	[dateOfMessages addObject:[NSString stringWithFormat:@"%@",[NSDate date]]];

    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfMessages count];
}

//---calculate the height for the message---
-(CGFloat) labelHeight:(NSString *) text {
	CGSize maximumLabelSize = CGSizeMake((bubbleFragment_width * 3) - 25,9999);
	CGSize expectedLabelSize = [text sizeWithFont:[UIFont systemFontOfSize: kAccountDetailFontSize] 
								constrainedToSize:maximumLabelSize 
									lineBreakMode:UILineBreakModeWordWrap]; 
	return expectedLabelSize.height;
}

//---returns the height for the table view row---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  
  	int labelHeight = [self labelHeight:[listOfMessages objectAtIndex:indexPath.row]];
	labelHeight -= bubbleFragment_height;
	if (labelHeight<0) labelHeight = 0;

	return (bubble_y + bubbleFragment_height * 2 + labelHeight) + 5;	
}  

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
		
	UILabel* dateLabel = nil;
    UILabel* messageLabel = nil;
	UIImageView *imageView_top_left = nil;
	UIImageView *imageView_top_middle = nil;
	UIImageView *imageView_top_right = nil;

	UIImageView *imageView_middle_left = nil;
	UIImageView *imageView_middle_right = nil;
	UIImageView *imageView_middle_middle = nil;
	
	UIImageView *imageView_bottom_left = nil;
	UIImageView *imageView_bottom_middle = nil;
	UIImageView *imageView_bottom_right = nil;
		
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
					
		//---date---
		dateLabel = [[[UILabel alloc] init] autorelease];
        dateLabel.tag = DATELABEL_TAG;
		[cell.contentView addSubview: dateLabel];
				
        //---top left---
		imageView_top_left = [[[UIImageView alloc] init] autorelease];
        imageView_top_left.tag = IMAGEVIEW_TAG_1;		
        [cell.contentView addSubview: imageView_top_left];
		
		//---top middle---
		imageView_top_middle = [[[UIImageView alloc] init] autorelease];
        imageView_top_middle.tag = IMAGEVIEW_TAG_2;
        [cell.contentView addSubview: imageView_top_middle];
		
		//---top right---
		imageView_top_right = [[[UIImageView alloc] init] autorelease];
        imageView_top_right.tag = IMAGEVIEW_TAG_3;
		[cell.contentView addSubview: imageView_top_right];
				
		//---middle left---
		imageView_middle_left = [[[UIImageView alloc] init] autorelease];
        imageView_middle_left.tag = IMAGEVIEW_TAG_4;
        [cell.contentView addSubview: imageView_middle_left];
		
		//---middle middle---
		imageView_middle_middle = [[[UIImageView alloc] init] autorelease];
        imageView_middle_middle.tag = IMAGEVIEW_TAG_5;
        [cell.contentView addSubview: imageView_middle_middle];
		
		//---middle right---
		imageView_middle_right = [[[UIImageView alloc] init] autorelease];
        imageView_middle_right.tag = IMAGEVIEW_TAG_6;
		[cell.contentView addSubview: imageView_middle_right];
		
		//---bottom left---
		imageView_bottom_left = [[[UIImageView alloc] init] autorelease];
        imageView_bottom_left.tag = IMAGEVIEW_TAG_7;
        [cell.contentView addSubview: imageView_bottom_left];
		
		//---bottom middle---
		imageView_bottom_middle = [[[UIImageView alloc] init] autorelease];
        imageView_bottom_middle.tag = IMAGEVIEW_TAG_8;
        [cell.contentView addSubview: imageView_bottom_middle];
		
		//---bottom right---
		imageView_bottom_right = [[[UIImageView alloc] init] autorelease];
        imageView_bottom_right.tag = IMAGEVIEW_TAG_9;
        [cell.contentView addSubview: imageView_bottom_right];
		
		//---message---
        messageLabel = [[[UILabel alloc] init] autorelease];
        messageLabel.tag = MESSAGELABEL_TAG;		
        [cell.contentView addSubview: messageLabel];

		//---set the images to display for each UIImageView---
		imageView_top_left.image = [UIImage imageNamed:@"bubble_top_left.png"];
		imageView_top_middle.image = [UIImage imageNamed:@"bubble_top_middle.png"];
		imageView_top_right.image = [UIImage imageNamed:@"bubble_top_right.png"];
		
		imageView_middle_left.image = [UIImage imageNamed:@"bubble_middle_left.png"];
		imageView_middle_middle.image = [UIImage imageNamed:@"bubble_middle_middle.png"];
		imageView_middle_right.image = [UIImage imageNamed:@"bubble_middle_right.png"];
		
		imageView_bottom_left.image = [UIImage imageNamed:@"bubble_bottom_left.png"];
		imageView_bottom_middle.image = [UIImage imageNamed:@"bubble_bottom_middle.png"];
		imageView_bottom_right.image = [UIImage imageNamed:@"bubble_bottom_right.png"];		
		
	} else {		
		//---reuse the old views---		
       dateLabel = (UILabel*)[cell.contentView viewWithTag: DATELABEL_TAG];
       messageLabel = (UILabel*)[cell.contentView viewWithTag: MESSAGELABEL_TAG];		
		
		imageView_top_left = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_1];
		imageView_top_middle = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_2];
		imageView_top_right = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_3];
			
		imageView_middle_left = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_4];
		imageView_middle_middle = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_5];
		imageView_middle_right = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_6];
			
		imageView_bottom_left = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_7];
		imageView_bottom_middle = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_8];
		imageView_bottom_right = (UIImageView*)[cell.contentView viewWithTag: IMAGEVIEW_TAG_9];				
	}
	
	//---calculate the height for the label---
	int labelHeight = [self labelHeight:[listOfMessages objectAtIndex:indexPath.row]];
	labelHeight -= bubbleFragment_height;
	if (labelHeight<0) labelHeight = 0;
	
	
	//---you can customize the look and feel for the date for each message here---
	dateLabel.frame = CGRectMake(0.0, 0.0, 200, 15.0);
	dateLabel.font = [UIFont boldSystemFontOfSize: kAccountDetailFontSize];
	dateLabel.textAlignment = UITextAlignmentLeft;
	dateLabel.textColor = [UIColor darkGrayColor];
	dateLabel.backgroundColor = [UIColor clearColor];
			
    //---top left---
	imageView_top_left.frame = CGRectMake(bubble_x, bubble_y, bubbleFragment_width, bubbleFragment_height);		
	//---top middle---
	imageView_top_middle.frame = CGRectMake(bubble_x + bubbleFragment_width, bubble_y, bubbleFragment_width, bubbleFragment_height);        
	//---top right---
	imageView_top_right.frame = CGRectMake(bubble_x + (bubbleFragment_width * 2), bubble_y, bubbleFragment_width, bubbleFragment_height);		
	//---middle left---
	imageView_middle_left.frame = CGRectMake(bubble_x, bubble_y + bubbleFragment_height, bubbleFragment_width, labelHeight);		
	//---middle middle---
	imageView_middle_middle.frame = CGRectMake(bubble_x + bubbleFragment_width, bubble_y + bubbleFragment_height, bubbleFragment_width, labelHeight);		
	//---middle right---
	imageView_middle_right.frame = CGRectMake(bubble_x + (bubbleFragment_width * 2), bubble_y + bubbleFragment_height, bubbleFragment_width, labelHeight);		
	//---bottom left---
	imageView_bottom_left.frame = CGRectMake(bubble_x, bubble_y + bubbleFragment_height + labelHeight, bubbleFragment_width, bubbleFragment_height ); 		
	//---bottom middle---
	imageView_bottom_middle.frame = CGRectMake(bubble_x + bubbleFragment_width, bubble_y + bubbleFragment_height + labelHeight, bubbleFragment_width, bubbleFragment_height);		
	//---bottom right---
	imageView_bottom_right.frame = CGRectMake(bubble_x + (bubbleFragment_width * 2), bubble_y + bubbleFragment_height + labelHeight, bubbleFragment_width, bubbleFragment_height );
		
	//---you can customize the look and feel for each message here---	
	messageLabel.frame = CGRectMake(bubble_x + 10, bubble_y + 5, (bubbleFragment_width * 3) - 25, (bubbleFragment_height * 2) + labelHeight - 10);
	messageLabel.font = [UIFont systemFontOfSize:kAccountDetailFontSize];		
    messageLabel.textAlignment = UITextAlignmentCenter;
    messageLabel.textColor = [UIColor darkTextColor];
	messageLabel.numberOfLines = 0; //---display multiple lines---
	messageLabel.backgroundColor = [UIColor clearColor];
	messageLabel.lineBreakMode = UILineBreakModeWordWrap;		
	
	dateLabel.text =[dateOfMessages objectAtIndex:indexPath.row];
	messageLabel.text = [listOfMessages objectAtIndex:indexPath.row];	
		
    return cell;
}

//---add a message to the table view---
-(IBAction) btnAdd:(id) sender {
	[listOfMessages addObject:itemName.text];	
	[dateOfMessages addObject:[NSString stringWithFormat:@"%@",[NSDate date]]];

	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[listOfMessages release];
	[dateOfMessages release];	 
    [super dealloc];
}

@end
