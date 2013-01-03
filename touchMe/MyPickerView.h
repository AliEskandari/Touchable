//
//  MyPickerView.h
//  touchMe
//
//  Created by Ali Eskandari on 12/31/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyPickerViewDelegate <UIPickerViewDelegate>
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
@end

@interface MyPickerView : UIPickerView <UIPickerViewDataSource>
@property (strong, nonatomic) NSMutableArray* source;
@property (assign, nonatomic) id<MyPickerViewDelegate> delegate;
@end
