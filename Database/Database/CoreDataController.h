//
//  CoreDataController.h
//  Database
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSManagedObjectModel* managedObjectModel_;
    NSPersistentStoreCoordinator* persistentStoreCoordinator_;
    NSManagedObjectContext* managedObjectContext_;
    NSMutableArray* dataSource_;
    UITableView* table_;
}

@property(nonatomic, retain) NSManagedObjectModel* managedObjectModel;
@property(nonatomic, retain) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property(nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property(nonatomic, retain) IBOutlet UITableView* table;
@property(nonatomic, retain) NSMutableArray* dataSource;


-(IBAction)searchData:(id)sender;
-(IBAction)addData:(id)sender;
-(IBAction)deleteData:(id)sender;
-(IBAction)editData:(id)sender;

@end
