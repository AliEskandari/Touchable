//
//  MenuScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 12/22/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginScreen.h"
#import "ProfileScreen.h"
#import "API.h"

@interface MenuScreen : UIViewController
@property IBOutlet UILabel *peopleLabel;
@property IBOutlet UILabel *randomizeLabel;
@property IBOutlet UILabel *mostTouchableLabel;
@property IBOutlet UILabel *profileLabel;
@property IBOutlet UILabel *recentActivityLabel;
@property IBOutlet UILabel *statisticsLabel;
@property IBOutlet UILabel *settingsLabel;
@property NSString* username;

@property IBOutlet UIButton *peopleBtn;
@property (strong, nonatomic) IBOutlet UIButton *randomizeBtn;
-(IBAction)peopleBtnTapped:(id)sender;
- (IBAction)randomizeBtnTapped:(id)sender;
- (IBAction)mostTouchableTapped:(id)sender;
- (IBAction)profileBtnTapped:(id)sender;
- (IBAction)settingsBtnTapped:(id)sender;
- (IBAction)recentActivityBtnTapped:(id)sender;
- (IBAction)statisticsBtnTapped:(id)sender;


@end
