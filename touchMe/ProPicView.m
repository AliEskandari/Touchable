//
//  ProPicView.m
//  touchMe
//
//  Created by Ali Eskandari on 1/23/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "ProPicView.h"

@implementation ProPicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Image:(UIImage *)image filterType:(NSNumber *)type {
	self = [super initWithFrame:frame];
    if (self) {
		[self setImage:image];
		if ([type isEqual:(id)[NSNull null]]) type = 0;
		if (type) {
			UIImage *filter = [UIImage imageNamed:([type integerValue] == 1) ? @"touch filter.png" : @"don't touch filter.png"];
			UIImageView *subView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
			[subView setImage:filter];
			[self insertSubview:subView atIndex:0];
		}
	}
	return self;
}

-(void)setProPicFilterType:(NSNumber*)type {
	if ([type isEqual:(id)[NSNull null]]) type = 0;
	if (type) {
		UIImage *filter = [UIImage imageNamed:([type integerValue] == 1) ? @"touch filter.png" : @"don't touch filter.png"];
		UIImageView *subView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		[subView setImage:filter];
		if ([self.subviews count]) [self.subviews[0] removeFromSuperview];
		[self insertSubview:subView atIndex:0];
	}
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
