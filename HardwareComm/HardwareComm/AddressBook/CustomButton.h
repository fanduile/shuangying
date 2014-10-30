//
//  CustomButton.h
//  SUSHIDO
//
//  Created by Mengke WANG on 7/13/10.
//  Copyright 2010 ABVENT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomGreenButton : UIButton 
{
    bool isChecked;
    
}
@property(nonatomic, assign) bool isChecked;

-(void)setChecked:(bool)checked;

@end

