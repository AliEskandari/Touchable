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
@property (strong, nonatomic) IBOutlet UIButton *peopleBtn;
-(IBAction)peopleBtnTapped:(id)sender;

@end
