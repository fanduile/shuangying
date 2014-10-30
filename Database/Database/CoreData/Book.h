//
//  Book.h
//  Database
//
//  Created by  on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSDate * copyright;
@property (nonatomic, retain) NSString * title;

@end
