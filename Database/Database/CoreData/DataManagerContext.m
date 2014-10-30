//
//  DataManagerContext.m
//  Database
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataManagerContext.h"
#import <CoreData/CoreData.h>

@implementation DataManagerContext


+ (DataManagerContext*) sharedInstance
{
    
}
/** 
 Returns the managed object context for the application. 
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application. 
 */ 
- (NSManagedObjectContext *) managedObjectContext 
{ 
    if (managedObjectContext != nil) { 
        return managedObjectContext; 
    } 
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator]; 
    if (coordinator != nil) { 
        managedObjectContext = [[NSManagedObjectContext alloc] init]; 
        [managedObjectContext setPersistentStoreCoordinator: coordinator]; 
    } 
    return managedObjectContext; 
} 


/** 
 Returns the managed object model for the application. 
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle. 
 */ 
- (NSManagedObjectModel *)managedObjectModel { 
    
    if (managedObjectModel != nil) { 
        return managedObjectModel; 
    } 
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];     
    return managedObjectModel; 
} 


/** 
 Returns the persistent store coordinator for the application. 
 If the coordinator doesn't already exist, it is created and the application's store added to it. 
 */ 
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{ 
    
    if (persistentStoreCoordinator != nil) { 
        return persistentStoreCoordinator; 
    } 
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Database.sqlite"]]; 
    //DLog(@"db: %@",[storeUrl absoluteURL]); 
    NSError *error; 
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]]; 
    
    // Allow inferred migration from the original version of the application. 
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys: 
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, 
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil]; 
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) { 
        // Handle the error. 
        //DLog(@"persistentStoreCoordinator failed! \n\n %@ \n\n %@", [error localizedDescription], [error localizedFailureReason]); 
    }     
    
    return persistentStoreCoordinator; 
} 

/** 
 Returns the path to the application's documents directory. 
 */ 
- (NSString *)applicationDocumentsDirectory 
{ 
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil; 
    return basePath; 
} 


/** 
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates. 
 */ 
- (void)applicationWillTerminate:(UIApplication *)application 
{ 
    
    NSError *error; 
    if (managedObjectContext != nil) { 
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) { 
            // Handle the error. 
            //DLog(@"app will terminate saving context failed!"); 
        }  
    } 
} 

@end
