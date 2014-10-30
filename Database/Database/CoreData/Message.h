//
//  Message.h
//  Database
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) User *user;

@end
