//
//  StreamPhotoScreen.h
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreamPhotoScreen : UIViewController
{
    //just the photo view and the photo title
    IBOutlet UIImageView* photoView;
    IBOutlet UILabel* lblTitle;
}

//action for when either button is pressed
-(IBAction)btnTouchDontTouchTapped:(id)sender;

@property (assign, nonatomic) NSNumber* IdPhoto;
@property (assign, nonatomic) NSNumber* IdUser;

@end
