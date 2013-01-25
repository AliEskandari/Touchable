//
//  MostTouchableScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 1/14/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileCell.h"
#import "API.h"
#import "UIAlertView+error.h"
#import "ProfileScreen.h"
#import "ProPicView.h"

@interface MostTouchableScreen : UIViewController <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate, InteractionDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property NSDictionary *source;
@property NSMutableArray *displayArray;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
- (void)didInteractionType:(NSInteger)type atIndex:(NSInteger)index;
@end
