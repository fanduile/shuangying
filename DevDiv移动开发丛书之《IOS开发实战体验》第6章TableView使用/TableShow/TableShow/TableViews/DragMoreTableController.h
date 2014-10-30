//
//  DragMoreTableController.h
//  TableShow
//
//  Created by Chendy on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoadFootView;
@interface DragMoreTableController : UIViewController
{
    UITableView* table_;
    LoadFootView* loadView;
    NSMutableArray* dataArray_;
    int index;
}
@property(nonatomic, retain) IBOutlet UITableView* table;
@property(nonatomic, retain) NSMutableArray* dataArray;
- (void)reloadTable;
-(void)getMoreData;
@end
