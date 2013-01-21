//
//  SettingsScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 1/15/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Resize.h"
#import <QuartzCore/QuartzCore.h>
#import "API.h"
#import "InfoSettingsScreen.h"

@interface SettingsScreen : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;

- (IBAction)btnChangePhotoTapped:(id)sender;
- (IBAction)btnEditInfoTapped:(id)sender;
@end
