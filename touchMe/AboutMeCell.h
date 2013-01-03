//
//  AboutMeCell.h
//  touchMe
//
//  Created by Ali Eskandari on 1/2/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AboutMeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel* textLabel;
@property (strong, nonatomic) IBOutlet UITextView* textView;
@end
