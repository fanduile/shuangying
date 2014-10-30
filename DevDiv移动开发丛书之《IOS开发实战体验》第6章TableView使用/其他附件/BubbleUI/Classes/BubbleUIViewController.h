//
//  BubbleUIViewController.h
//  BubbleUI
//
//  Created by Wei-Meng Lee on 4/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleUIViewController : UIViewController {
    IBOutlet UITextField *itemName;
    IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) UITextField *itemName;
@property (nonatomic, retain) UITableView *tableView;

-(IBAction) doneEditing:(id) sender;
-(IBAction) btnAdd:(id) sender;

@end

