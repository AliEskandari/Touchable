//
//  SettingsScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 1/15/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "SettingsScreen.h"

@interface SettingsScreen () {
	BOOL photoChosen;
}

@end

@implementation SettingsScreen

@synthesize userPhoto;
@synthesize photoImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	NSURL* imageURL = [[API sharedInstance] urlForImageWithId:[[[API sharedInstance] user] objectForKey:@"IdUser"] isThumb:NO];
	[photoImageView setImageWithURL: imageURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnChangePhotoTapped:(id)sender{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentModalViewController:imagePickerController animated:YES];
}

- (IBAction)btnEditInfoTapped:(id)sender {
	[self performSegueWithIdentifier:@"ShowEditInfo" sender:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	image = [image thumbnailImage:image.size.width transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
	userPhoto = UIImageJPEGRepresentation(image, 70);
	UIGraphicsBeginImageContextWithOptions(photoImageView.bounds.size, photoImageView.opaque, 0.0);
	[image drawInRect:photoImageView.bounds];
	UIGraphicsEndImageContext();
	[photoImageView setImage:image];;
	photoChosen = YES;
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
	[self setPhotoImageView:nil];
	[super viewDidUnload];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber *)sender {
    if ([@"ShowEditInfo" compare: segue.identifier]==NSOrderedSame) {
        EditInfoScreen* editInfoScreen = segue.destinationViewController;
		
    }
}

@end
