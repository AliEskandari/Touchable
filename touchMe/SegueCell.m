//
//  SegueCell.m
//  touchMe
//
//  Created by Ali Eskandari on 1/2/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "SegueCell.h"

@implementation SegueCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
