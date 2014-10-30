//
//  BubbleUIAppDelegate.h
//  BubbleUI
//
//  Created by Wei-Meng Lee on 4/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BubbleUIViewController;

@interface BubbleUIAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BubbleUIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BubbleUIViewController *viewController;

@end

