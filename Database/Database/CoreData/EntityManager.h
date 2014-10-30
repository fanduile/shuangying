//
//  EntityManager.h
//  RabitRun
//
//  Created by RealTool on 11-10-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@class NSManagedObjectContext, NSManagedObjectModel, NSPersistentStoreCoordinator,NSManagedObject,NSFetchRequest;


@interface EntityManager : NSObject
{
@private
    NSManagedObjectContext         *managedObjectContext;
    NSManagedObjectModel           *managedObjectModel;
    NSPersistentStoreCoordinator   *persistentStoreCoordinator;
    
    NSError* lastError_;
}

@property(readonly)NSError* lastError;

@property(readonly)NSManagedObjectContext         *managedObjectContext;

+ (EntityManager*)shareManager;

- (NSManagedObject*)newObject:(Class)cls;

- (NSManagedObject*)newObject:(Class)cls entityName:(NSString*)name;

- (void)insertObject:(NSManagedObject*)obj;

- (void)deleteObject:(NSManagedObject*)obj;

- (BOOL)save;

- (NSArray *)executeFetchRequest:(NSFetchRequest *)request;    


- (NSUInteger) countForFetchRequest: (NSFetchRequest *)request;

@end
