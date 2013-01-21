//
//  WelcomeScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 12/26/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "WelcomeScreen.h"
#import "API.h"
#import "UIImage+Resize.h"
#import "UIAlertView+error.h"

@interface WelcomeScreen ()
-(void)uploadPhoto:(UIImage*) photo;
@end

@implementation WelcomeScreen

@synthesize welcomeLabel;
@synthesize btnCaption;
@synthesize photoInstructions;
@synthesize photoRules;
@synthesize btnChangePhoto;
@synthesize userPhoto;
@synthesize savedInfo;
@synthesize photoChosen;
@synthesize doneRegisteringDelegate;


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
	welcomeLabel.font = [UIFont fontWithName:@"Segoe WP" size:14];
	photoRules.font = [UIFont fontWithName:@"Segoe WP" size:13];
	photoInstructions.font = [UIFont fontWithName:@"Segoe WP" size:13];
	btnCaption.font = [UIFont fontWithName:@"Segoe WP" size:11.5];
    
    
	welcomeLabel.textColor = [UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0];
    photoRules.textColor = [UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0];
    photoInstructions.textColor = [UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0];
    btnCaption.textColor = [UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0];
    
	savedInfo = nil;
	photoChosen = NO;
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

-(IBAction)btnEditInfoTapped:(id)sender{
	if (photoChosen == NO)
		[[[UIAlertView alloc]initWithTitle:nil message:@"Please choose a photo for your profile" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
	else [self performSegueWithIdentifier:@"ShowEditInfo" sender:nil];
}

-(void)uploadPhoto:(UIImage*) photo {
    //upload the image and the title to the web service
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"upload", @"command", UIImageJPEGRepresentation(photo,70), @"file", nil] onCompletion:^(NSDictionary *json) {
		//completion
		if (![json objectForKey:@"error"]) {
			//success
			[[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your photo is uploaded" delegate:nil cancelButtonTitle:@"Yay!" otherButtonTitles: nil] show];
		} else {
			//error, check for expired session and if so - authorize the user
			NSString* errorMsg = [json objectForKey:@"error"];
			[UIAlertView error:errorMsg];
			if ([@"Authorization required" compare:errorMsg]==NSOrderedSame) {
				[self performSegueWithIdentifier:@"ShowLogin" sender:nil];
			}
		}
	}];
}


#pragma mark - Image picker delegate methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	image = [image thumbnailImage:image.size.width transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
	userPhoto = UIImageJPEGRepresentation(image, 0);
	UIGraphicsBeginImageContextWithOptions(btnChangePhoto.bounds.size, btnChangePhoto.opaque, 0.0);
	[image drawInRect:btnChangePhoto.bounds];
	UIGraphicsEndImageContext();
	[btnChangePhoto setBackgroundImage:image forState:UIControlStateNormal];
	photoChosen = YES;
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - EditInfoScreenDismissed delegate methods
-(void)editInfoScreenDismissed:(NSMutableDictionary*)completedInfo{
	savedInfo = completedInfo;
}

-(void) doneRegistering:(NSString *)username password:(NSString *)pass{
	[self dismissViewControllerAnimated:NO completion:nil];
	[self.doneRegisteringDelegate doneRegistering:username password:pass];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([@"ShowEditInfo" compare:segue.identifier] == NSOrderedSame) {
		EditInfoScreen* editInfoScreen = segue.destinationViewController;
		editInfoScreen.editInfoScreenDismissedDelegate = self;
		editInfoScreen.doneRegisteringDelegate = self;
		editInfoScreen.enteredInfo = self.savedInfo;
		editInfoScreen.userPhoto = userPhoto;
	}
}

- (void)viewDidUnload {
	welcomeLabel = nil;
	btnCaption = nil;
    [self setPhotoInstructions:nil];
    [self setPhotoRules:nil];
	[super viewDidUnload];
}

@end
