//
//  RandomizeScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 1/14/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomizeScreen : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *randomizeLabel;
@property (strong, nonatomic) IBOutlet UIButton *changeFiltersBtn;
@property (strong, nonatomic) IBOutlet UIButton *randomizeBtn;
- (IBAction)randomizeBtnTapped:(id)sender;
- (IBAction)filtersBtnTapped:(id)sender;

@end
