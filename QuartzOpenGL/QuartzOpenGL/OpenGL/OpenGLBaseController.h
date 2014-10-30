//
//  OpenGLBaseController.h
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLView;
@interface OpenGLBaseController : UIViewController
{
    GLuint textures[2];
}

- (void)setupView:(GLView*)view;
- (void)loadTexture:(NSString *)name intoLocation:(GLuint)location;
- (void)drawChannel;
- (void)lightOn;
- (void)ligntOff;
- (void)drawView:(GLView*)view;
@end
