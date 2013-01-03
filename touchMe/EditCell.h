//
//  EditCell.h
//  touchMe
//
//  Created by Ali Eskandari on 12/29/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EditCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UITextField* field;

@end
