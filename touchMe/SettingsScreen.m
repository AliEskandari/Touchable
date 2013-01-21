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
	photoChosen = NO;
	
	NSURL* imageURL = [[API sharedInstance] urlForImageWithId:[[[API sharedInstance] user] objectForKey:@"IdUser"] isThumb:NO];
	AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest: [NSURLRequest requestWithURL:imageURL] success:^(UIImage *image) {
		//add it to the view
		[photoImageView setImage:image];
	}];
	NSOperationQueue* queue = [[NSOperationQueue alloc] init];
	[queue addOperation:imageOperation];

}

-(void) viewWillDisappear:(BOOL)animated {
	if (photoChosen) {
		//upload the image and the title to the web service
		[[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"uploadPhoto", @"command", UIImageJPEGRepresentation(photoImageView.image,70), @"file", nil] onCompletion:^(NSDictionary *json) {
			//completion
			if (![json objectForKey:@"error"]) {
				//success
				[[[UIAlertView alloc]initWithTitle:nil message:@"Photo Updated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
			} else {
				//error
				NSString* errorMsg = [json objectForKey:@"error"];
				[UIAlertView error:errorMsg];
			}
		}];
	}
	[super viewWillDisappear:animated];
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
	[[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"getProfile", @"command", [[[API sharedInstance] user] objectForKey:@"IdUser" ], @"IdUser", nil] onCompletion:^(NSDictionary *json) {
		if (![json objectForKey:@"error"]){
			NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[json objectForKey:@"result"][0]];
			[self performSegueWithIdentifier:@"ShowEditInfo" sender:result];
		} else {
			[UIAlertView error:@"Database connection failed"];
		}
	}];
	
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	image = [image thumbnailImage:image.size.width transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
	userPhoto = UIImageJPEGRepresentation(image, 0);
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSMutableDictionary *)sender {
    if ([@"ShowEditInfo" compare: segue.identifier]==NSOrderedSame) {
        InfoSettingsScreen* infoSettingsScreen = segue.destinationViewController;
		infoSettingsScreen.enteredInfo = sender;
    }
}

@end
