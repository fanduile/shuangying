//
//  LocationMapDemoMasterViewController.h
//  LocationMap
//
//  Created by Chendy on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationMapDemoDetailViewController;

@interface LocationMapDemoMasterViewController : UITableViewController
{
    NSArray* dataArray_;
}

@property (strong, nonatomic) LocationMapDemoDetailViewController *detailViewController;
@property(nonatomic, retain) NSArray* dataArray;

@end
