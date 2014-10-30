//
//  TableCell.h
//  TableShow
//
//  Created by Chendy on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
{
    UILabel* titleLabel_;
    UILabel* descLabel_;
    UILabel* timeLabel_;
    UILabel* statusLabel_;
    UIImageView* iconView_;
    UIImageView* statusView_;
    UIImageView* rightIcon_;
    
}

@property(nonatomic, retain) IBOutlet UILabel* titleLabel;
@property(nonatomic, retain) IBOutlet UILabel* descLabel;
@property(nonatomic, retain) IBOutlet UILabel* timeLabel;
@property(nonatomic, retain) IBOutlet UILabel* statusLabel;
@property(nonatomic, retain) IBOutlet UIImageView* iconView;
@property(nonatomic, retain) IBOutlet UIImageView* statusView;
@property(nonatomic, retain) IBOutlet UIImageView* rightIcon;

@end
