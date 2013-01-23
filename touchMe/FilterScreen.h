//
//  FilterScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 1/8/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MyPickerView.h"
#import "DataSource.h"
#import "SexCell.h"
#import "AgeCell.h"
#import "SegueCell.h"
#import "AutoCompScreen.h"
#import "FilterNavController.h"
#import "API.h"

@protocol FilterScreenDismissedDelegate <NSObject>
-(void) filterScreenDismissed;
@end

@interface FilterScreen : UIViewController <MyPickerViewDelegate, AutoCompScreenDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addFilterBtn;
@property (strong, nonatomic) MyPickerView* filterPicker;
@property (strong, nonatomic) NSMutableArray* filterList;
@property (assign, nonatomic) id<FilterScreenDismissedDelegate> delegate;

- (IBAction)backBtnTapped:(id)sender;
- (IBAction)addFilterBtnTapped:(id)sender;
-(void) updateFilterList;

@end
