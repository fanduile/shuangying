//
//  GatherViewController.m
//  HappyJoke
//
//  Created by Betel on 11-7-25.
//  Copyright 2011年 231313. All rights reserved.
//

#import "GatherViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBook/ABMultiValue.h>
#import <AddressBook/ABRecord.h>
#import "CustomButton.h"
#import "ChineseToPinyin.h"

@implementation GatherViewController
@synthesize cellPhoneTable;
@synthesize sureButton;
@synthesize phonelLable;
@synthesize phoneNO;
@synthesize tongXunIfo;
@synthesize tongXunNameIfo;
@synthesize isSave;

@synthesize lableView;
@synthesize bottleView;
@synthesize bottle;
@synthesize fullName;
@synthesize partName;
@synthesize phoneInfo;
@synthesize numberX;
@synthesize addreeBookSelArray;
@synthesize addressBookDic;
@synthesize addressBookAllArray;
@synthesize listArray;

//@synthesize selectButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [cellPhoneTable release];
    [super dealloc];
    [sureButton release];
    [tongXunIfo release];
    [tongXunNameIfo release];
    [fullName release];
    [partName release];
    [addreeBookSelArray release];
  
}

/**把数据处理成可以按中文拼音首字母索引排序的表格，和音乐库的效果是一样的*/
- (NSMutableDictionary*) processAddressDataSource:(NSArray*) dataSource
{
    
    NSMutableDictionary* resultDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray* characterArray = [[NSArray alloc] initWithObjects:@"A", @"B", @"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    for(int i = 0; i < [characterArray count]; i++)
    {
        NSString* key = [characterArray objectAtIndex:i];
        NSMutableArray* valArray = [[NSMutableArray alloc] initWithCapacity:0]; 
        for(int i = 0; i < [dataSource count]; i++)
        {
            NSMutableDictionary* addressDic = [dataSource objectAtIndex:i];
            NSString* name = [addressDic objectForKey:@"name"];
            NSString* charStr = [[ChineseToPinyin firstPinyinCharacter:name] uppercaseString];
            if([charStr isEqualToString:key])
            {
                [valArray addObject:addressDic];
            }            
        }
        if([valArray count] > 0)
        {
            [resultDic setObject:valArray forKey:key];
        }        
    }
    return resultDic;   
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
    addreeBookSelArray = [[NSMutableArray alloc]initWithCapacity:0];
    addressBookAllArray = [[NSMutableArray alloc] initWithCapacity:0];
    addressBookDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    numberX = [[NSMutableArray alloc]init];
    tongXunIfo  = [[NSMutableArray alloc]init];
    tongXunNameIfo  = [[NSMutableArray alloc]init];
    phoneInfo = [[NSMutableDictionary alloc]init];
    ABAddressBookRef addressBook = ABAddressBookCreate();
    NSMutableArray*  peopleArray = (NSMutableArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    nCount = [peopleArray count];
    for (int i = 0; i < nCount; i++)
    {
        ABRecordRef* people = (ABRecordRef*)[peopleArray objectAtIndex:i];
        ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(people, kABPersonPhoneProperty);
        int count = ABMultiValueGetCount(phones);
        NSString* phoneNumber = nil;
        bool hasNumber = false;
        for(int j = 0 ;j < count;j++)
        {
            phoneNumber    = (NSString *)ABMultiValueCopyValueAtIndex(phones, j);  
            if(phoneNumber != nil && [phoneNumber length] > 0)
            {
                hasNumber = true;
            }       
        }
        if(!hasNumber)//如果没有号码，则直接读下一个
        {
            continue;
        }
        NSString* firstName = (NSString*)ABRecordCopyValue(people, kABPersonFirstNameProperty);
        NSString* mideName = (NSString*)ABRecordCopyValue(people, kABPersonMiddleNameProperty);
        NSString* lastName = (NSString*)ABRecordCopyValue(people, kABPersonLastNameProperty);
        NSMutableString* full = [[NSMutableString alloc]initWithString:@""];
        if(lastName != nil)
        {
            [full appendFormat:@"%@", lastName];
        }

        if(mideName != nil)
        {
            [full appendFormat:@"%@", mideName];
        }
        if(firstName != nil)
        {
            [full appendFormat:@"%@", firstName];
        }
        [firstName release];
        [mideName release];
        [lastName release];
        NSString* nameStr = [full copy];
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithCapacity:3];
        [dic setObject:nameStr forKey:@"name"];
        [dic setObject:phoneNumber forKey:@"phoneNumber"];
        NSString* tagStr = [NSString stringWithFormat:@"%d", i];
        [dic setObject:tagStr forKey:@"tag"];
        [addressBookAllArray addObject:dic];      
        [full release];
    }
    NSMutableDictionary* addressBD = [self processAddressDataSource:addressBookAllArray];
    addressBookDic = addressBD;
    NSMutableArray* array  = [[NSMutableArray alloc]initWithArray:
                              [[self.addressBookDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    self.listArray = array;
    [array release];
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain  target:self action:@selector(showjoketaleview)]; 
    self.navigationItem.leftBarButtonItem=leftItem;
    [leftItem release];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"qdbt.png"] forState:UIControlStateNormal];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"qdbt_hover.png"] forState:UIControlStateHighlighted];
}

-(IBAction)addToContact
{
    printf("--------addToContact----Execute!!!------\n");
    ABAddressBookRef iPhoneAddressBook = ABAddressBookCreate();        
    ABRecordRef newPerson = ABPersonCreate();
    CFErrorRef error = NULL; 
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, @"John", &error);
    ABRecordSetValue(newPerson, kABPersonLastNameProperty, @"Doe", &error);
    ABRecordSetValue(newPerson, kABPersonOrganizationProperty, @"Model Metrics", &error);
    ABRecordSetValue(newPerson, kABPersonJobTitleProperty, @"Senior Slacker", &error);
    
    //phone number
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiPhone, @"1-555-555-5555", kABPersonPhoneMainLabel, NULL);
    ABMultiValueAddValueAndLabel(multiPhone, @"1-123-456-7890", kABPersonPhoneMobileLabel, NULL);            
    ABMultiValueAddValueAndLabel(multiPhone, @"1-987-654-3210", kABOtherLabel, NULL);        
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone,&error);
    CFRelease(multiPhone);
    
    //email
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiEmail, @"johndoe@modelmetrics.com", kABWorkLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonEmailProperty, multiEmail, &error);
    CFRelease(multiEmail);
    
    //address
    ABMutableMultiValueRef multiAddress = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);        
    NSMutableDictionary *addressDictionary = [[NSMutableDictionary alloc] init];        
    [addressDictionary setObject:@"750 North Orleans Street, Ste 601" forKey:(NSString *) kABPersonAddressStreetKey];
    [addressDictionary setObject:@"Chicago" forKey:(NSString *)kABPersonAddressCityKey];
    [addressDictionary setObject:@"IL" forKey:(NSString *)kABPersonAddressStateKey];
    [addressDictionary setObject:@"60654" forKey:(NSString *)kABPersonAddressZIPKey];        
    ABMultiValueAddValueAndLabel(multiAddress, addressDictionary, kABWorkLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonAddressProperty, multiAddress,&error);
    CFRelease(multiAddress);        
    
    ABAddressBookAddRecord(iPhoneAddressBook, newPerson, &error);
    ABAddressBookSave(iPhoneAddressBook, &error);
    if (error != NULL) 
    {                
        NSLog(@"Danger Will Robinson! Danger!");                
    }
}
    


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	
	// Notifies users about errors associated with the interface
	switch (result) {
		case MessageComposeResultCancelled:
			if (DEBUG) NSLog(@"Result: canceled");
			break;
		case MessageComposeResultSent:
			if (DEBUG) NSLog(@"Result: Sent");
			break;
		case MessageComposeResultFailed:
			if (DEBUG) NSLog(@"Result: Failed");
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];	
}


-(void)showjoketaleview
{
 [self.navigationController popViewControllerAnimated:YES];
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

//在tableview中有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [listArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //获取分组
    NSString *key = [listArray objectAtIndex:section];
    //获取分组里面的数组
    NSMutableArray *array =[addressBookDic objectForKey:key];
    //    NSLog(@"numberOfRowsInSection array=%@",[array description]);
    return [array count];
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* headerStr = [listArray objectAtIndex:section];
    NSString* resultStr = [NSString stringWithFormat:@"  %@",headerStr];
    return resultStr;
}

    
//给tableviewcell添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //    NSLog(@"sectionIndexTitlesForTableView listArray = %@", [listArray description]);
    return listArray;
}

    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    static NSString *SimpleTableIdentifier=@"SimpleTableIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:nil];
    NSInteger section = [indexPath section];
    if (cell==nil)   
    {
        cell=[[[UITableViewCell alloc]
               initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier]autorelease];
    }
    
    NSString *key = [listArray objectAtIndex:section];
    NSArray *array =[addressBookDic objectForKey:key];
    NSMutableDictionary* addrDic = [array objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    UILabel* nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 20.0f, 135.0f, 18.0f)];
    [nickNameLabel setText:[addrDic objectForKey:@"name"]];
    [[cell contentView] addSubview:nickNameLabel];
    NSLog(@"%@",[cell contentView]);
    
    UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(145.0f, 20.0f, 110.0f, 18.0f)];
    numLabel.backgroundColor = [UIColor clearColor];
    nickNameLabel.backgroundColor = [UIColor clearColor];
    [numLabel setText:[addrDic objectForKey:@"phoneNumber"]];
    [[cell contentView] addSubview:numLabel];
    [cell.textLabel setNumberOfLines:0];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [nickNameLabel release];
    [numLabel release];
    lableView = [[UIView alloc]initWithFrame:CGRectMake(260, 12, 25, 25)];
    lableView.backgroundColor = [UIColor clearColor];
    bottle=[UIImage imageNamed:@"piont50.png"];
    bottleView=[[UIImageView alloc]initWithFrame:CGRectMake(260, 12, 25,25)];
    bottleView.image=bottle;
    [lableView addSubview:bottleView];
    [bottleView release];
    [[cell contentView] addSubview: bottleView];
    CGRect btnFrame = CGRectMake(260, 12, 25, 25);
    CustomGreenButton*  selectButton=[[CustomGreenButton alloc] initWithFrame:btnFrame];
    [selectButton awakeFromNib];
    [selectButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    NSString* tagStr = [addrDic objectForKey:@"tag"];
    selectButton.tag = [tagStr intValue];
    [cell addSubview:selectButton];
    [selectButton release];
    bottleView.userInteractionEnabled = YES;
    
    return cell;
}


-(void)click:(id)sender
{
    CustomGreenButton* btn = (CustomGreenButton*)sender;
    [btn setChecked:!btn.isChecked];
    NSString* tagStr = [NSString stringWithFormat:@"%d", btn.tag];
    if(btn.isChecked)
    {
        for(int i = 0; i < [addressBookAllArray count]; i++)
        {
            NSMutableDictionary* addrDic = [addressBookAllArray objectAtIndex:i];
            NSString* tagDicStr = [addrDic objectForKey:@"tag"];
            if([tagStr isEqualToString:tagDicStr])
            {
                [addreeBookSelArray addObject:addrDic];
                break;
            }
        }
    }
    else
    {
        for(int i = 0; i < [addreeBookSelArray count]; i++)
        {
            NSMutableDictionary* dic = [addreeBookSelArray objectAtIndex:i];
            NSString* dicTag = [dic objectForKey:@"tag"];
            if([dicTag isEqualToString:tagStr])
            {
                [addreeBookSelArray removeObjectAtIndex:i];
                break;
            }
        }
    }          
}

// 短信分享
//- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result 
//{
//	switch (result)
//    {
//		case MessageComposeResultCancelled:
//			//if (DEBUG) NSLog(@"Result: canceled");
//			break;
//		case MessageComposeResultSent:
//			//if (DEBUG) NSLog(@"Result: Sent");
//			break;
//		case MessageComposeResultFailed:
//			//if (DEBUG) NSLog(@"Result: Failed");
//			break;
//		default:
//			break;
//	}
//	[self dismissModalViewControllerAnimated:YES];	
//}

@end
