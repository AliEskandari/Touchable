//
//  EditInfoScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 12/29/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
#import "MyPickerView.h"
#import "AutoCompScreen.h"
#import "EditCell.h"
#import "AboutMeCell.h"
#import "SegueCell.h"
#import <QuartzCore/QuartzCore.h>
#include <CommonCrypto/CommonDigest.h>
#include "API.h"
#include "UIAlertView+error.h"

#define kSalt @"adlfu3489tyh2jnkLIUGI&%EV(&0982cbgrykxjnk8855"

@protocol EditInfoScreenDelegate <NSObject>
-(void)editInfoScreenDismissed:(NSMutableDictionary*)completedInfo;
@end

@protocol DoneRegisteringDelegate <NSObject>
-(void) doneRegistering:(NSString*)username password:(NSString*)pass;
@end

@interface EditInfoScreen : UITableViewController <UITextViewDelegate, UITextFieldDelegate, MyPickerViewDelegate, AutoCompScreenDelegate>
{
	MyPickerView *sexPickerView;
	MyPickerView* agePickerView;
	NSMutableDictionary* enteredInfo;
}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnDone;
@property (strong, nonatomic) UITextField *username;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *reEnter;
@property (strong, nonatomic) UITextField *age;
@property (strong, nonatomic) UITextField *sex;
@property (strong, nonatomic) UITextView *aboutMe;
@property (strong, nonatomic) UILabel *country;
@property (strong, nonatomic) UILabel *state;
@property (strong, nonatomic) UILabel *city;
@property (strong, nonatomic) UILabel *school;
@property (strong, nonatomic) DataSource* dataSource;
@property(assign, nonatomic) id<EditInfoScreenDelegate> editInfoScreenDismissedDelegate;
@property(assign, nonatomic) id<DoneRegisteringDelegate> doneRegisteringDelegate;
@property (strong, nonatomic) NSMutableDictionary *enteredInfo;
@property (assign, nonatomic) NSData* userPhoto;

-(void)autoCompScreenDismissed:(NSString*)string tag:(NSInteger)tag;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(IBAction)btnDoneTapped:(id)sender;
@end
