//
//  FilterNavController.h
//  touchMe
//
//  Created by Ali Eskandari on 1/11/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterScreen.h"

@interface FilterNavController : UINavigationController

@property NSMutableArray* filterList;
@property id filterScreenDismissedDelegate;

@end
