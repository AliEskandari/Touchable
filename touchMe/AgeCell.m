//
//  AgeCell.m
//  touchMe
//
//  Created by Ali Eskandari on 1/8/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "AgeCell.h"

@implementation AgeCell

@synthesize textLabel;
@synthesize age1TextField;
@synthesize toLabel;
@synthesize age2TextField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		textLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 5, 50, 22)];
		[self addSubview:textLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
