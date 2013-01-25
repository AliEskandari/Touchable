//
//  PeopleScreen.h
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"
#import "UIAlertView+error.h"
#import "FilterNavController.h"
#import "FilterScreen.h"
#import "ProfileScreen.h"

@interface PeopleScreen : UIViewController <PhotoViewDelegate, UIScrollViewDelegate, FilterScreenDismissedDelegate, InteractionDelegate> {
    IBOutlet UIBarButtonItem* btnFilter;
    IBOutlet UIScrollView* listView;
}
- (IBAction)btnFilterTapped:(id)sender;
- (void)filterScreenDismissed;
- (void) didInteractionType:(NSInteger)type atIndex:(NSInteger)index;
@end
