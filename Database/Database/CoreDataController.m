//
//  CoreDataController.m
//  Database
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoreDataController.h"
#import "User.h"
#import "DataManagerContext.h"
#import "Message.h"
#import <CoreData/CoreData.h>
#import "Book.h"

@implementation CoreDataController
@synthesize managedObjectContext = managedObjectContext_;
@synthesize managedObjectModel = managedObjectModel_;
@synthesize persistentStoreCoordinator = persistentStoreCoordinator_;
@synthesize table = table_;
@synthesize dataSource = dataSource_;

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
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"CoreDataBooks" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];   
    
    NSURL *storeURL = nil;
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel_];
    storeURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    storeURL = [storeURL URLByAppendingPathComponent:@"CoreDataBooks.sqlite"];
    [persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType 
                                             configuration:nil 
                                                       URL:storeURL 
                                                   options:nil 
                                                     error:&error];
    managedObjectContext_ = [[NSManagedObjectContext alloc] init];
    [managedObjectContext_ setPersistentStoreCoordinator:persistentStoreCoordinator_];
    [managedObjectContext_ setMergePolicy:NSOverwriteMergePolicy];
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:0];
    self.dataSource = array;
}

-(IBAction)searchData:(id)sender
{
    [dataSource_ removeAllObjects];
    NSError* error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Book" 
										inManagedObjectContext:managedObjectContext_]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(author == %@)" ,@"RealTool"];
    [fetchRequest setPredicate:predicate];
	NSArray *array = [managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
    [dataSource_ addObjectsFromArray:array];
    [table_ reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(dataSource_ != nil)
    {
        return [dataSource_ count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    Book* book = [dataSource_ objectAtIndex:row];
    UITableViewCell* cell =  (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UserCell"];
    }
    cell.textLabel.text = book.author;//[dic objectForKey:@"author"];
    cell.detailTextLabel.text = book.title;//[dic objectForKey:@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}




-(IBAction)addData:(id)sender
{
    NSEntityDescription* description = [NSEntityDescription entityForName: @"Book" 
                                                   inManagedObjectContext:managedObjectContext_];
    Book* obj = [[[Book alloc] initWithEntity:description insertIntoManagedObjectContext:nil] autorelease];
    obj.author = @"RealTool";
    obj.copyright = [NSDate date];
    obj.title = @"iOS Develop";
    [managedObjectContext_ insertObject:obj];
    [managedObjectContext_ save:nil];
}

-(IBAction)deleteData:(id)sender
{
    NSError* error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Book" 
										inManagedObjectContext:managedObjectContext_]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(author == %@)" ,@"RealTool"];
    [fetchRequest setPredicate:predicate];
	NSArray *array = [managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
    for(Book* book in array)
    {
        [managedObjectContext_ deleteObject:book];
    }
    [managedObjectContext_ save:nil];
    [self.table reloadData];
}

-(IBAction)editData:(id)sender
{
    NSError* error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Book" 
										inManagedObjectContext:managedObjectContext_]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(author == %@)" ,@"RealTool"];
    [fetchRequest setPredicate:predicate];
	NSArray *array = [managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
    for(Book* book in array)
    {
        book.title = @"iPhone UI Design";
    }
    [managedObjectContext_ save:nil];
    [self.table reloadData];
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
