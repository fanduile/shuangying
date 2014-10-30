//
//  CameraViewController.m
//  HardwareComm
//
//  Created by Chendy on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "PlayVidioController.h"

@implementation CameraViewController
@synthesize imageView = imageView_;
@synthesize cameraBgView = cameraBgView_;
@synthesize playVideoButton = playVideoButton_;
@synthesize filePath = filePath_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	if (buttonIndex == 0) 
    {
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) 
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //imagePicker.showsCameraControls = NO;
            if(actionSheet.tag == 0)
            {
                imagePicker.delegate = self;
                imagePicker.delegate = self;
                //imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                imagePicker.cameraCaptureMode =UIImagePickerControllerCameraCaptureModePhoto;
                [self presentModalViewController:imagePicker animated:YES];
                [imagePicker release];
            }
            else if(actionSheet.tag == 1)
            {
                imagePicker.delegate = self;
                //imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                //imagePicker.showsCameraControls = NO;
                //[imagePicker.view addSubview:cameraBgView_];
                imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie,nil];
                imagePicker.cameraCaptureMode =UIImagePickerControllerCameraCaptureModeVideo;
                imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
                [self presentModalViewController:imagePicker animated:YES];
                [imagePicker release];
            }
		} 
        else 
        {
			[actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
		}
	} 
    else if (buttonIndex == 1) 
    {
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        if(actionSheet.tag == 1)
        {
            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie,(NSString*)kUTTypeMPEG,nil];
        }
		if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
			imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentModalViewController:imagePicker animated:YES];
			[imagePicker release];
		}
		
		else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
			imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
			[self presentModalViewController:imagePicker animated:YES];
			[imagePicker release];
		}
		else
        {
			[actionSheet dismissWithClickedButtonIndex:buttonIndex animated: YES];
		}
	}
    
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate Methods

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker  
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo 
{
    imageView_.image = selectedImage;
    [picker dismissModalViewControllerAnimated:YES];
}


//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    NSLog(@"info = %@",[info description]);
//    playVideoButton_.enabled = YES;
//    self.filePath = [info objectForKey:@"UIImagePickerControllerMediaURL"];
//    [picker dismissModalViewControllerAnimated:YES];
//}

-(IBAction)takePicktureButtonClick:(id)sender
{
    UIActionSheet *cameraSheet = [[UIActionSheet alloc] initWithTitle:nil 
															 delegate:self 
													cancelButtonTitle:@"取消" 
											   destructiveButtonTitle:nil 
													otherButtonTitles:@"拍照",@"用户相册",nil];
	cameraSheet.actionSheetStyle = UIActionSheetStyleDefault;
    cameraSheet.tag = 0;
	[cameraSheet showInView:self.view];
	[cameraSheet release];
}

-(IBAction)takeVideoButtonClick:(id)sender
{
    UIActionSheet *cameraSheet = [[UIActionSheet alloc] initWithTitle:nil 
															 delegate:self 
													cancelButtonTitle:@"取消" 
											   destructiveButtonTitle:nil 
													otherButtonTitles:@"摄像",@"用户相册",nil];
	cameraSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[cameraSheet showInView:self.view];
    cameraSheet.tag = 1;
	[cameraSheet release];
}

-(IBAction)cancelCemera:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)playVideoBtnClick:(id)sender
{
    PlayVidioController* vc = [[PlayVidioController alloc]initWithNibName:@"PlayVidioController" bundle:nil];
    vc.videoPath = self.filePath;
    [self presentModalViewController:vc animated:YES];
    [vc release];
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

-(void)dealloc
{
    [filePath_ release];
    [imageView_ release];
    [cameraBgView_ release];
    [playVideoButton_ release];
    [super dealloc];
}

@end
