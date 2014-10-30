//
//  DataManagerContext.h
//  Database
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManagerContext : NSObject
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator; 
    NSManagedObjectModel *managedObjectModel; 
    NSManagedObjectContext *managedObjectContext; 
}

+ (DataManagerContext*) sharedInstance; 
- (NSString *)applicationDocumentsDirectory;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (void)applicationWillTerminate:(UIApplication *)application;
@end
