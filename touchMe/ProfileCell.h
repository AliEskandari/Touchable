//
//  ProfileCell.h
//  touchMe
//
//  Created by Ali Eskandari on 1/14/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProPicView.h"

@interface ProfileCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numRankLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numTouchMeLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (strong, nonatomic) IBOutlet ProPicView *proPicView;

@end
