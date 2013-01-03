//
//  MyPickerView.m
//  touchMe
//
//  Created by Ali Eskandari on 12/31/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "MyPickerView.h"

@implementation MyPickerView

@synthesize source;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.showsSelectionIndicator = YES;
		self.opaque = NO;
		self.dataSource = self;
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [source count];
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
