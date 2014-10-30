//
//  BubbleTableController.h
//  TableShow
//
//  Created by Chendy on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleTableController : UIViewController<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>
{
    UITableView* bubbleTable_;
    NSMutableArray* dataSource_;
    BOOL msgFrom;
    UITextField* msgTextField_;
}

@property(nonatomic, retain) IBOutlet UITableView* bubbleTable;
@property(nonatomic, retain) NSMutableArray* dataSource;
@property(nonatomic, retain) IBOutlet UITextField* msgTextField;

- (UIView *)getBubble:(NSString *)bubbleText from:(BOOL)isSelf;
-(void)hideKeyboard;
@end
