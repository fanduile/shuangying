//
//  CoreLocationViewController.h
//  LocationMap
//
//  Created by Chendy on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreLocationViewController : UIViewController
{
    UILabel* latitudeLabel_;
    UILabel* longitudeLabel_;
}

@property(nonatomic, retain) IBOutlet UILabel* latitudeLabel;
@property(nonatomic, retain) IBOutlet UILabel* longitudeLabel;

-(IBAction)startLocation:(id)sender;

@end
