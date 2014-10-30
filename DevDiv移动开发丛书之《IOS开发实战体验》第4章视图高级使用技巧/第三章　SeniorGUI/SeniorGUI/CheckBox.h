//
//  CheckBox.h
//  SeniorGUI
//
//  Created by Chendy on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckBox : UIButton
{
    bool isChecked;
}
@property(nonatomic, assign) bool isChecked;
-(void)setChecked;
@end
