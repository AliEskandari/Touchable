//
//  ProfileScreen.h
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PhotoView.h"

@interface ProfileScreen : UIViewController

//action for when either button is pressed
-(IBAction)btnTouchDontTouchTapped:(id)sender;
@property (retain, nonatomic) NSNumber* ProfileId;
@property (strong, nonatomic) __block NSMutableDictionary *profData;
@property (strong, nonatomic) UILabel *aboutMeLabel, *aboutMeTextLabel;
@property (retain, nonatomic) PhotoView *photoView;
@property (retain, nonatomic) NSNumber* interactionType;

@end
