//
//  TableCell.m
//  TableShow
//
//  Created by Chendy on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell
@synthesize titleLabel = titleLabel_;
@synthesize descLabel = descLabel_;
@synthesize timeLabel = timeLabel_;
@synthesize statusLabel = statusLabel_;
@synthesize iconView = iconView_;
@synthesize rightIcon = rightIcon_;
@synthesize statusView = statusView_;


- (void)dealloc
{
    self.iconView = nil;
    self.titleLabel = nil;
    [titleLabel_ release];
    [descLabel_ release];
    [statusLabel_ release];
    [timeLabel_ release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

@end
