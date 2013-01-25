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
#import "ProPicView.h"

@protocol InteractionDelegate <NSObject>
- (void)didInteractionType:(NSNumber*)type atIndex:(NSInteger)index;
@end

@interface ProfileScreen : UIViewController

//action for when either button is pressed
-(IBAction)btnTouchDontTouchTapped:(id)sender;
@property (retain, nonatomic) NSNumber* ProfileId, *interactionType;
@property NSInteger index;
@property (strong, nonatomic) id<InteractionDelegate> interactionDelegate;

@end
