//
//  OpenGLBaseController.m
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OpenGLBaseController.h"
#import "GLView.h"
#import "ConstantsAndMacros.h"

#define WALL_CNT   10
#define DRAW_CNT   3

#define WOOD_TC_OFFSET     0
#define BRICK_TC_OFFSET    8
#define FLOOR_TC_OFFSET    16
#define CEILING_TC_OFFSET  24

@implementation OpenGLBaseController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"OpenGL演示";
    CGRect	rect = [[UIScreen mainScreen] bounds];
	GLView* glView = [[GLView alloc]initWithFrame:rect];
	glView.controller = self;
	self.view = glView;
    [glView release];
}

- (void)loadTexture:(NSString *)name intoLocation:(GLuint)location 
{
	
    CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
	if (textureImage == nil) 
	{
		NSLog(@"Failed to load texture image");
		return;
	}
	NSInteger texWidth = CGImageGetWidth(textureImage);
    NSInteger texHeight = CGImageGetHeight(textureImage);
	GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	
	CGContextRef textureContext = CGBitmapContextCreate(
														textureData,
														texWidth,
														texHeight,
														8, texWidth * 4,
														CGImageGetColorSpace(textureImage),
														kCGImageAlphaPremultipliedLast);
	// Rotate the image -- These two lines are new
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	
	CGContextDrawImage(textureContext,
					   CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight),
					   textureImage);
	
	CGContextRelease(textureContext);
	glBindTexture(GL_TEXTURE_2D, location);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glEnable(GL_TEXTURE_2D);
}

- (void)lightOn
{
	// Enable lighting
    glEnable(GL_LIGHTING);
	
    // Turn the first light on
    glEnable(GL_LIGHT0);
    
    // Define the ambient component of the first light
    static const Color3D light0Ambient[] = {{0.05, 0.05, 0.05, 1.0}};
	glLightfv(GL_LIGHT0, GL_AMBIENT, (const GLfloat *)light0Ambient);
    
    // Define the diffuse component of the first light
    static const Color3D light0Diffuse[] = {{0.4, 0.4, 0.4, 1.0}};
	glLightfv(GL_LIGHT0, GL_DIFFUSE, (const GLfloat *)light0Diffuse);
    
    // Define the specular component and shininess of the first light
    static const Color3D light0Specular[] = {{0.7, 0.7, 0.7, 1.0}};
    glLightfv(GL_LIGHT0, GL_SPECULAR, (const GLfloat *)light0Specular);
    
    // Define the position of the first light
	// const GLfloat light0Position[] = {10.0, 10.0, 10.0}; 
    static const Vertex3D light0Position[] = {{10.0, 10.0, 10.0}};
	glLightfv(GL_LIGHT0, GL_POSITION, (const GLfloat *)light0Position); 
	
    // Calculate light vector so it points at the object
    static const Vertex3D objectPoint[] = {{0.0, 0.0, -3.0}};
    const Vertex3D lightVector = Vector3DMakeWithStartAndEndPoints(light0Position[0], objectPoint[0]);
    glLightfv(GL_LIGHT0, GL_SPOT_DIRECTION, (GLfloat *)&lightVector);
	
    // Define a cutoff angle. This defines a 90° field of vision, since the cutoff
    // is number of degrees to each side of an imaginary line drawn from the light's
    // position along the vector supplied in GL_SPOT_DIRECTION above
    glLightf(GL_LIGHT0, GL_SPOT_CUTOFF, 25.0);
}
- (void)ligntOff
{
	glDisable(GL_LIGHTING);
	glDisable(GL_LIGHT0);
}

-(void)setupView:(GLView*)view
{
	const GLfloat zNear = 0.01, zFar = 1000.0, fieldOfView = 45.0; 
	GLfloat size; 
	glEnable(GL_DEPTH_TEST);
	glMatrixMode(GL_PROJECTION); 
	size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0); 
	CGRect rect = view.bounds; 
	glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / 
			   (rect.size.width / rect.size.height), zNear, zFar); 
	glViewport(0, 0, rect.size.width, rect.size.height);  
	glMatrixMode(GL_MODELVIEW);    
	
	//[self lightOn];//打开光效
	glGenTextures(2, &textures[0]);
	[self loadTexture:@"wenli.png" intoLocation:textures[0]];
	[self loadTexture:@"logo.png" intoLocation:textures[1]];
	
	glLoadIdentity(); 
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f); 
}

- (void)drawView:(GLView*)view;
{
	[self drawChannel];
}


- (void)drawChannel
{
	const GLfloat combinedTextureCoordinate[] = {
        // The wood wall texture
        0.0, 1.0,       // Vertex[0~2] top left of square
        0.0, 0.5,       // Vertex[3~5] bottom left of square
        0.5, 0.5,       // Vertex[6~8] bottom right of square
        0.5, 1.0,       // Vertex[9~11] top right of square
        
        // The brick texture
        0.5, 1.0,
        0.5, 0.5,
        1.0, 0.5,
        1.0, 1.0,
        
        // Floor texture
        0.0, 0.5,
        0.0, 0.0,
        0.5, 0.0,
        0.5, 0.5,
        
        // Ceiling texture
        0.5, 0.5,
        0.5, 0.0,
        1.0, 0.0,
        1.0, 0.5
    };
	
	const GLfloat squareTextureCoords[] = 
	{
		0, 1,       // top left
		0, 0,       // bottom left
		1, 0,       // bottom right
		1, 1        // top right
	};
	
	const GLfloat squareVerticeRight[] = 
	{		
		0.8,  0.8, -2.6,               // Top left
		0.8, -0.8, -2.6,              // Bottom left
		0.8, -0.8, -1.0,               // Bottom right
		0.8,  0.8, -1.0                 // Top right
	};
	
	const GLfloat squareVerticesLeft[] = 
	{			
		-0.8,  0.8, -1.0,// Top left
		-0.8, -0.8, -1.0,// Bottom left
		-0.8, -0.8, -2.6, // Bottom right
		-0.8,  0.8, -2.6  // Top right
	};
	
	const GLfloat squareVerticesDown[] = 
	{			
		-0.8, -0.8, -2.6,// Top left
		-0.8, -0.8, -1.0,// Bottom left
        0.8, -0.8, -1.0, // Bottom right
        0.8, -0.8, -2.6  // Top right
	};
	
	const GLfloat squareVerticesUp[] = 
	{			
		-0.8, 0.8, -1.0,// Top left
		-0.8, 0.8, -2.6,// Bottom left
        0.8, 0.8, -2.6 , // Bottom right
        0.8, 0.8, -1.0 // Top right
	};
	
	const GLfloat squareVerticesCenter[] = 
	{			
		-0.8, 0.8, -1.0 * WALL_CNT,// Top left
		-0.8, -0.8, -1.0 * WALL_CNT,// Bottom left
		0.8, -0.8, -1.0 * WALL_CNT, // Bottom right
		0.8, 0.8, -1.0 * WALL_CNT// Top right
	};
	
	const GLfloat picLeft[] = 
	{			
		-0.799,  0.8, -1.0,// Top left
		-0.799, -0.8, -1.0,// Bottom left
		-0.799, -0.8, -2.6, // Bottom right
		-0.799,  0.8, -2.6 // Top right
	};
	
	const GLfloat picRight[] = 
	{		
		0.799,  0.8, -4.2,               // Top left
		0.799, -0.8, -4.2,              // Bottom left
		0.799, -0.8, -2.6,               // Bottom right
		0.799,  0.8, -2.6                // Top right
	};
	//glPopMatrix();
    glClearColor(0.7, 0.7, 0.7, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glEnable(GL_TEXTURE_2D);
	glColor4f(1.0, 1.0, 1.0, 1.0);      //NEW
	glEnableClientState(GL_VERTEX_ARRAY);	
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);                // NEW
	glBindTexture(GL_TEXTURE_2D, textures[0]);
	glPushMatrix();
	for(int i = 0; i < WALL_CNT; i++)
	{
		glVertexPointer(3, GL_FLOAT, 0, squareVerticeRight);
		glTexCoordPointer(2, GL_FLOAT, 0, &combinedTextureCoordinate[WOOD_TC_OFFSET]);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glTranslatef(0, 0, -1.6);
	}	
	glPopMatrix();
	
	glPushMatrix();
	for(int i = 0; i < WALL_CNT; i++)
	{
		glVertexPointer(3, GL_FLOAT, 0, squareVerticesLeft);
		glTexCoordPointer(2, GL_FLOAT, 0, &combinedTextureCoordinate[BRICK_TC_OFFSET]);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glTranslatef(0, 0, -1.6);
	}	
	glPopMatrix();
	
	glPushMatrix();
	for(int i = 0; i < WALL_CNT; i++)
	{
		glVertexPointer(3, GL_FLOAT, 0, squareVerticesDown);
		glTexCoordPointer(2, GL_FLOAT, 0, &combinedTextureCoordinate[FLOOR_TC_OFFSET]);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glTranslatef(0, 0, -1.6);
	}	
	glPopMatrix();
	
	glPushMatrix();
	for(int i = 0; i < WALL_CNT; i++)
	{
		glVertexPointer(3, GL_FLOAT, 0, squareVerticesUp);
		glTexCoordPointer(2, GL_FLOAT, 0, &combinedTextureCoordinate[CEILING_TC_OFFSET]);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glTranslatef(0, 0, -1.6);
	}	
	glPopMatrix();
	
	
//	glPushMatrix();
//	glBindTexture(GL_TEXTURE_2D, textures[1]);
//	glVertexPointer(3, GL_FLOAT, 0, squareVerticesCenter);
//	glTexCoordPointer(2,GL_FLOAT, 0,squareTextureCoords); 
//	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
//	glPopMatrix();
//	
//	glPushMatrix();
//	for(int i = 0; i < DRAW_CNT; i++)
//	{				
//		glBindTexture(GL_TEXTURE_2D, textures[1]);
//		glVertexPointer(3, GL_FLOAT, 0, picLeft);
//		glTexCoordPointer(2,GL_FLOAT, 0,squareTextureCoords); 
//		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);			
//		glTranslatef(0, 0, -3.2);
//	}
//	glPopMatrix();
//	
//	glPushMatrix();
//	for(int i = 0; i < DRAW_CNT; i++)
//	{		
//		glBindTexture(GL_TEXTURE_2D, textures[1]);
//		glVertexPointer(3, GL_FLOAT, 0, picRight);
//		glTexCoordPointer(2,GL_FLOAT, 0,squareTextureCoords); 
//		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);		
//		glTranslatef(0, 0, -3.2);
//	}
//	glPopMatrix();
	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);               // NEW
	glDisable(GL_TEXTURE_2D); 	
	
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
