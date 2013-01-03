//
//  EditCell.m
//  touchMe
//
//  Created by Ali Eskandari on 12/29/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "EditCell.h"

@implementation EditCell

@synthesize textLabel;
@synthesize field;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		// General initialization of cell format
		
	}
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
	if(selected){
		[field setEnabled:TRUE];
		[field becomeFirstResponder];
	}
}

@end
