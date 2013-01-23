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

@synthesize peopleLabel;
@synthesize randomizeLabel;
@synthesize mostTouchableLabel;
@synthesize profileLabel;
@synthesize recentActivityLabel;
@synthesize statisticsLabel;
@synthesize settingsLabel;

-(IBAction)peopleBtnTapped:(id)sender{
	[self performSegueWithIdentifier:@"ShowPeople" sender:nil];
}

- (IBAction)randomizeBtnTapped:(id)sender {
	[self performSegueWithIdentifier:@"ShowRandomize" sender:nil];
}

- (IBAction)mostTouchableTapped:(id)sender {
	[self performSegueWithIdentifier:@"ShowMostTouchable" sender:nil];
}

- (IBAction)profileBtnTapped:(id)sender {
	[self performSegueWithIdentifier:@"ShowMyProfile" sender:[[[API sharedInstance] user] objectForKey:@"IdUser"]];
}

- (IBAction)settingsBtnTapped:(id)sender {
	[self performSegueWithIdentifier:@"ShowSettings" sender:nil];
}

- (IBAction)recentActivityBtnTapped:(id)sender {
	[self performSegueWithIdentifier:@"ShowRecentActivity" sender:nil];
}

- (IBAction)statisticsBtnTapped:(id)sender {
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationItem.hidesBackButton = YES;
    
	peopleLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:14];
    randomizeLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:14];
    mostTouchableLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:14];
    profileLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:14];
    recentActivityLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:14];
    statisticsLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:14];
    settingsLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:14];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
	[self setPeopleBtn:nil];
    [self setPeopleLabel:nil];
    [self setRandomizeLabel:nil];
    [self setMostTouchableLabel:nil];
    [self setProfileLabel:nil];
    [self setRecentActivityLabel:nil];
    [self setStatisticsLabel:nil];
    [self setSettingsLabel:nil];
	[self setRandomizeBtn:nil];
	[super viewDidUnload];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber *)sender {
    if ([@"ShowMyProfile" compare: segue.identifier]==NSOrderedSame) {
        ProfileScreen* ProfileScreen = segue.destinationViewController;
		ProfileScreen.ProfileId = sender;
    }
}



@end
