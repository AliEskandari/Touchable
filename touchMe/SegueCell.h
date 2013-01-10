//
//  SegueCell.h
//  touchMe
//
//  Created by Ali Eskandari on 1/2/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegueCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel* textLabel;
@property (strong, nonatomic) IBOutlet UILabel* detailTextLabel;
@property (strong, nonatomic) IBOutlet UILabel* detailLabel;
@end
