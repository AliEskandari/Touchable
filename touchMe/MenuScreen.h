//
//  MenuScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 12/22/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginScreen.h"

@interface MenuScreen : UIViewController
@property IBOutlet UILabel *peopleLabel;
@property IBOutlet UILabel *randomizeLabel;
@property IBOutlet UILabel *mostTouchableLabel;
@property IBOutlet UILabel *profileLabel;
@property IBOutlet UILabel *recentActivityLabel;
@property IBOutlet UILabel *statisticsLabel;
@property IBOutlet UILabel *settingsLabel;

@property IBOutlet UIButton *peopleBtn;
-(IBAction)peopleBtnTapped:(id)sender;

@end
