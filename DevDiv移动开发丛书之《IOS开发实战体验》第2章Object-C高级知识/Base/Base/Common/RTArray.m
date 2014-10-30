//
//  RTArray.m
//  Base
//
//  Created by Chendy on 11-12-6.
//  Copyright (c) 2011年 睿拓(RealTool)工作室(realtool@163.com). All rights reserved.
//

#import "RTArray.h"

@implementation NSArray(RTArray)
-(void)writeToPlistFile:(NSString*)fileName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory , NSUserDomainMask , YES );
    NSString* documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager* manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:documentsDirectory])
    {
        [manager removeItemAtPath:documentsDirectory error:nil];
    }
    [self writeToFile:documentsDirectory atomically:YES];
}
@end
