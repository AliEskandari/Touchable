//
//  MenuScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 12/22/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "MenuScreen.h"
#import "API.h"
#import "LoginScreen.h"

@interface MenuScreen ()

@end

@implementation MenuScreen

-(IBAction)peopleBtnTapped:(id)sender{
	[self performSegueWithIdentifier:@"ShowPeople" sender:nil];
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
	[self setPeopleBtn:nil];
	[super viewDidUnload];
}
@end
