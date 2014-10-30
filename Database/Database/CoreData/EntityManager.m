//
//  EntityManager.m
//  RabitRun
//
//  Created by RealTool on 11-10-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EntityManager.h"
#import <CoreData/CoreData.h>

@implementation EntityManager

static EntityManager* em = nil;

@synthesize lastError = lastError_;

@synthesize managedObjectContext;


- (void)resetLastError {
	[lastError_ release];
	lastError_ = nil;
}

+ (EntityManager*)shareManager
{
    @synchronized(self)
    {
        if (em == nil) {
            em = [[EntityManager alloc] init];
            [em createManager];
        }
    }
    return em;
}

- (void)createManager
{
        
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"MyCoreData" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];   
    
    
    NSURL *storeURL = nil;
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    storeURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    storeURL = [storeURL URLByAppendingPathComponent:@"MyCoreData.sqlite"];
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType 
                                             configuration:nil 
                                                       URL:storeURL 
                                                   options:nil 
                                                     error:&error];
    
    
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    [managedObjectContext setMergePolicy:NSOverwriteMergePolicy];
        

    
        
    
    
    
}

- (NSManagedObject*)newObject:(Class)cls
{
    NSString* name = [NSString stringWithFormat:@"%s" , object_getClassName(cls)];
    return [self newObject:cls entityName:name];
}

- (NSManagedObject*)newObject:(Class)cls entityName:(NSString*)name
{
    
    NSManagedObject *	obj  = nil;
	@synchronized(self)
	{
        
        NSEntityDescription* description = [NSEntityDescription entityForName:name 
                                                       inManagedObjectContext:managedObjectContext];
        if (description == nil) {
            @throw [[NSException alloc] initWithName:@"core date" reason:@"create NSEntityDescription faild!" userInfo:nil];
        }
		obj = [[[cls alloc] initWithEntity:description insertIntoManagedObjectContext:nil] autorelease];
	}
	return obj;
}

- (void)insertObject:(NSManagedObject*)obj
{

	@synchronized(self)
	{
		[managedObjectContext insertObject:obj];
	}
}

- (void)deleteObject:(NSManagedObject*)obj
{
    @synchronized(self)
	{
		[managedObjectContext deleteObject:obj];
	}
}

- (BOOL)save
{
    [self resetLastError];
	
	NSError *error = nil;

	@synchronized(self)
	{
		[managedObjectContext save:&error];
	}
	if (error) {
		lastError_ = [error retain];
	}
	return error == nil;
}

- (NSArray *)executeFetchRequest:(NSFetchRequest *)request
{
    
    [self resetLastError];
    NSError *error = nil;
    NSArray *array  = nil;
	@synchronized(self)
	{
        if (request.entity) {
            array = [managedObjectContext executeFetchRequest:request 
                                                        error:&error];
        }
		
	}
	
	if (error) {
		lastError_ = [error retain];
		array = nil;
	}

    return array;
}


- (NSUInteger)countForFetchRequest: (NSFetchRequest *)request
{
    
    [self resetLastError];
    //- (NSUInteger) countForFetchRequest: (NSFetchRequest *)request error: (NSError **)error
    
    NSUInteger count = 0;
    NSError* error = nil;

	@synchronized(self)
	{
		count = [managedObjectContext countForFetchRequest:request 
                                                    error:&error];
	}
	
	if (error) {
		lastError_ = [error retain];
		count = 0;
	}
    
    return count;
}


- (void)dealloc
{
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    [managedObjectContext release];
    [lastError_ release];
    [super dealloc];
}



@end
