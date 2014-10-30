//
//  HardwareCommViewController.h
//  HardwareComm
//
//  Created by Chendy on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HardwareCommViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* table_;
    NSArray* array_;
}

@property(nonatomic, retain) IBOutlet UITableView* table;
@property(nonatomic, retain) IBOutlet NSArray* array;


@end
