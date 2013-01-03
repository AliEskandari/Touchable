//
//  AboutMeCell.m
//  touchMe
//
//  Created by Ali Eskandari on 1/2/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "AboutMeCell.h"

@implementation AboutMeCell

@synthesize textView;
@synthesize textLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
