 //
//  LoginScreen.m
//  iReporter
//
//  Created by Marin Todorov on 09/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "LoginScreen.h"
#import "UIAlertView+error.h"
#import "API.h"
#include <CommonCrypto/CommonDigest.h>

#define kSalt @"adlfu3489tyh2jnkLIUGI&%EV(&0982cbgrykxjnk8855"

@implementation LoginScreen


-(void)viewDidLoad {
    [super viewDidLoad];
	UIImage *navigationBarBackground = [UIImage imageNamed:@"menubar_no_title.png"];
	[self.navigationController.navigationBar setBackgroundImage:navigationBarBackground forBarMetrics:UIBarMetricsDefault];
	NSDictionary *titleBarAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIColor blackColor], UITextAttributeTextShadowColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, [UIFont fontWithName:@"Segoe WP Black" size:18], UITextAttributeFont, nil];
	self.navigationController.navigationBar.titleTextAttributes = titleBarAttributes;
    
	[[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0]];
	[[UIBarButtonItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0f, 0.0f) forBarMetrics:UIBarMetricsDefault];
	[[UINavigationBar appearance] setTitleVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];
	[[UIBarButtonItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
														   [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0],
														   UITextAttributeTextColor,
														   [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
														   UITextAttributeTextShadowColor,
														   [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
														   UITextAttributeTextShadowOffset,
														   [UIFont fontWithName:@"Segoe WP" size:0.0],
														   UITextAttributeFont,
														   nil] forState:UIControlStateNormal];

	//focus on the username field / show keyboard
    [fldUsername becomeFirstResponder];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)btnLoginTapped:(UIButton*)sender {
	//form fields validation
	if (fldUsername.text.length < 4 || fldPassword.text.length < 4) {
		[UIAlertView error:@"Enter username and password over 4 chars each."];
		return;
	}
	//salt the password
	NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", fldPassword.text, kSalt];
	//prepare the hashed storage
	NSString* hashedPassword = nil;
	unsigned char hashedPasswordData[CC_SHA1_DIGEST_LENGTH];
	//hash the pass
	NSData *data = [saltedPassword dataUsingEncoding: NSUTF8StringEncoding];
	if (CC_SHA1([data bytes], [data length], hashedPasswordData)) {
		hashedPassword = [[NSString alloc] initWithBytes:hashedPasswordData length:sizeof(hashedPasswordData) encoding:NSASCIIStringEncoding];
	} else {
		[UIAlertView error:@"Password can't be sent"];
		return;
	}
	
	NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"login", @"command", fldUsername.text, @"username", hashedPassword, @"password", nil];
	//make the call to the web API
	[[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
		//result returned
		NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
		if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"IdUser"] intValue]>0) {
			[[API sharedInstance] setUser: res];
			[self performSegueWithIdentifier:@"LoggedIn" sender:nil];
			//show message to the user
			[[[UIAlertView alloc] initWithTitle:@"Logged in" message:[NSString stringWithFormat:@"Welcome %@",[res objectForKey:@"username"]] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
		} else {
			//error
			[UIAlertView error:[json objectForKey:@"error"]];
		}
	}];

}
-(IBAction)btnRegisterTapped:(id)sender{
	[self performSegueWithIdentifier:@"ShowWelcome" sender:nil];
}


@end
