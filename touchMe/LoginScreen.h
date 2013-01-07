//
//  LoginScreen.h
//  iReporter
//
//  Created by Marin Todorov on 09/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfoScreen.h"
#import "WelcomeScreen.h"

@interface LoginScreen : UIViewController <DoneRegisteringDelegate>
{
    //the login form fields
    IBOutlet UITextField* fldUsername;
    IBOutlet UITextField* fldPassword;
}

//action for when either button is pressed
-(IBAction)btnLoginTapped:(id)sender;
-(IBAction)btnRegisterTapped:(id)sender;
-(void) doneRegistering:(NSString *)username password:(NSString *)pass;

@end