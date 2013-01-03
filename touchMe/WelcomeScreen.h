//
//  WelcomeScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 12/26/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfoScreen.h"

@interface WelcomeScreen : UIViewController <UIImagePickerControllerDelegate, EditInfoScreenDelegate>
@property  IBOutlet UIButton *btnChangePhoto;
@property  IBOutlet UILabel *welcomeLabel;
@property  IBOutlet UILabel *btnCaption;
@property  IBOutlet UILabel *photoInstructions;
@property  IBOutlet UILabel *photoRules;
@property (copy, nonatomic) NSData* userPhoto;
@property (copy, nonatomic) NSMutableDictionary* savedInfo;

-(IBAction)btnChangePhotoTapped:(id)sender;
-(IBAction)btnEditInfoTapped:(id)sender;
-(void)editInfoScreenDismissed:(NSMutableDictionary*)completedInfo;

@end

