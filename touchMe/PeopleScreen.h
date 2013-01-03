//
//  PeopleScreen.h
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"

@interface PeopleScreen : UIViewController <PhotoViewDelegate> {
    IBOutlet UIBarButtonItem* btnFilter1;
    IBOutlet UIBarButtonItem* btnMenu;
    IBOutlet UIScrollView* listView;
}
@end
