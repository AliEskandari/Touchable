//
//  EditInfoScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 12/29/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "EditInfoScreen.h"

@interface EditInfoScreen ()
@end

@implementation EditInfoScreen

@synthesize username;
@synthesize password;
@synthesize reEnter;
@synthesize age;
@synthesize sex;
@synthesize aboutMe;
@synthesize country;
@synthesize state;
@synthesize city;
@synthesize school;

@synthesize dataSource;
@synthesize enteredInfo;
@synthesize editInfoScreenDismissedDelegate;
@synthesize doneRegisteringDelegate;
@synthesize btnDone;
@synthesize userPhoto;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	dataSource = [[DataSource alloc] init];
	sexPickerView = [[MyPickerView alloc] init];
	sexPickerView.delegate = self;
	sexPickerView.source = dataSource.sexes;
	
	agePickerView = [[MyPickerView alloc] init];
	agePickerView.delegate = self;
	agePickerView.source = dataSource.ages;
	
	if (!enteredInfo) enteredInfo = [[NSMutableDictionary alloc] init];
	
	self.navigationItem.rightBarButtonItem = btnDone;
	
    // Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
	[agePickerView selectRow:19 inComponent:0 animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
	if(username.text.length > 0) [enteredInfo setValue:username.text forKey:@"username"];
	if(password.text.length > 0)[enteredInfo setValue:password.text forKey:@"password"];
	if(reEnter.text.length > 0)[enteredInfo setValue:reEnter.text forKey:@"reEnter"];
	if(age.text.length > 0)[enteredInfo setValue:age.text forKey:@"age"];
	if(sex.text.length > 0)[enteredInfo setValue:sex.text forKey:@"sex"];
	if(aboutMe.text.length > 0)[enteredInfo setValue:aboutMe.text forKey:@"aboutMe"];
	if(country.text.length > 0)[enteredInfo setValue:country.text forKey:@"country"];
	if(state.text.length > 0)[enteredInfo setValue:state.text forKey:@"state"];
	if(city.text.length > 0)[enteredInfo setValue:city.text forKey:@"city"];
	if(school.text.length > 0)[enteredInfo setValue:school.text forKey:@"school"];
	
	if([self.editInfoScreenDismissedDelegate respondsToSelector:@selector(editInfoScreenDismissed:)])
	{
		[self.editInfoScreenDismissedDelegate editInfoScreenDismissed:enteredInfo];
	}
	
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   	return (section != 2) ? 3 : 4;
}

/* ALLOCATE, LABEL, RETURN TABLE CELLS */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
	// Set up the cell…
	switch (indexPath.section) {
		case 0:
		{
			CellIdentifier = @"EditCell";
			EditCell* editCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (editCell == nil) {
				editCell = [[EditCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
			}
			switch (indexPath.row) {
				case 0:
					editCell.field.text = [enteredInfo objectForKey:@"username"];
					editCell.textLabel.text = @"Username*";
					editCell.field.tag = 1;
					username = editCell.field;
					break;
				case 1:
					editCell.field.text = [enteredInfo objectForKey:@"password"];
					editCell.textLabel.text = @"Password*";
					password = editCell.field;
					editCell.field.tag = 2;
					editCell.field.secureTextEntry = TRUE;
					break;
				case 2:
					editCell.field.text = [enteredInfo objectForKey:@"reEnter"];
					editCell.textLabel.text = @"Re-Enter*";
					reEnter = editCell.field;
					editCell.field.tag = 3;
					editCell.field.secureTextEntry = TRUE;
					break;
				default:
					break;
					
			}
			editCell.field.delegate = self;
			return editCell;
			
		}
			break;
		case 1:
		{
			EditCell* editCell;
			if (indexPath.row != 2) {
				CellIdentifier = @"EditCell";
				editCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				if (editCell == nil) {
					editCell = [[EditCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
				}
			}
			switch (indexPath.row) {
				case 0:
					editCell.field.text = [enteredInfo objectForKey:@"age"];
					editCell.textLabel.text = @"Age*";
					editCell.field.tag = 4;
					age = editCell.field;
					editCell.field.inputView = agePickerView;
					break;
				case 1:
					editCell.field.text = [enteredInfo objectForKey:@"sex"];
					editCell.textLabel.text = @"Sex*";
					editCell.field.tag = 5;
					sex = editCell.field;
					editCell.field.inputView  = sexPickerView;
					break;
				case 2:
				{
					CellIdentifier = @"AboutMeCell";
					AboutMeCell* aboutMeCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
					if (aboutMeCell == nil) {
						aboutMeCell = [[AboutMeCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
					}
					aboutMeCell.textLabel.text = @"About Me                                        (90 char. max)";
					aboutMeCell.textView.delegate = self;
					aboutMeCell.textView.text = [enteredInfo objectForKey:@"aboutMe"];
					return aboutMeCell;
				}
					break;
				default:
					break;
			}
			editCell.field.delegate = self;
			return editCell;
		}
			break;
		case 2:
		{
			CellIdentifier = @"SegueCell";
			SegueCell* segueCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (segueCell == nil) {
				segueCell = [[SegueCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
			}
			switch (indexPath.row) {
				case 0:
					segueCell.detailTextLabel.text = [enteredInfo objectForKey:@"country"];
					segueCell.tag = 0;
					segueCell.textLabel.text = @"Country*";
					country = segueCell.detailTextLabel;
					break;
				case 1:
					segueCell.detailTextLabel.text = [enteredInfo objectForKey:@"state"];
					segueCell.tag = 1;
					segueCell.textLabel.text = @"State*";
					state = segueCell.detailTextLabel;
					break;
				case 2:
					segueCell.detailTextLabel.text = [enteredInfo objectForKey:@"city"];
					segueCell.tag = 2;
					segueCell.textLabel.text = @"City*";
					city = segueCell.detailTextLabel;
					break;
				case 3:
					segueCell.detailTextLabel.text = [enteredInfo objectForKey:@"school"];
					segueCell.tag = 3;
					segueCell.textLabel.text = @"School*";
					school = segueCell.detailTextLabel;
					break;
				default:
					break;
			}
			return segueCell;
		}
			break;
		default:
			break;
	}
	return NULL;
}

#pragma mark - TableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 2) {
		EditCell* cell = (EditCell*)[tableView cellForRowAtIndexPath:indexPath];
		[self performSegueWithIdentifier:@"ShowAutoComp" sender:cell];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return (indexPath.section == 1 && indexPath.row == 2) ? 120 : 45;
}


/* SET UP CELL FONTS AND SHADOWS */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.textLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:12];
	UIView *selectionColor = [[UIView alloc] init];
	selectionColor.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(51.0/255.0) blue:(21.0/255.0) alpha:1];
	cell.selectedBackgroundView = selectionColor;
	
	if ([cell isMemberOfClass:[AboutMeCell class]]) {
		AboutMeCell* aboutMeCell = (AboutMeCell*) cell;
		aboutMeCell.textView.font = [UIFont fontWithName:@"Segoe WP Black" size:12];
		aboutMeCell.textView.layer.borderWidth = 1;
		aboutMeCell.textView.layer.cornerRadius = 8;
		aboutMeCell.textView.layer.borderColor = [[UIColor grayColor] CGColor];
		aboutMeCell.textView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
		aboutMeCell.textView.layer.shadowColor = [UIColor blackColor].CGColor;
	} else if ([cell isMemberOfClass:[EditCell class]]){
		EditCell *editCell = (EditCell*) cell;
		editCell.field.font = [UIFont fontWithName:@"Segoe WP Black" size:18];
		editCell.field.layer.shadowOffset = CGSizeMake(0.0, -1.0);
		editCell.detailTextLabel.layer.shadowColor = [UIColor blackColor].CGColor;
	} else {
		cell.textLabel.textColor = [UIColor blackColor];
		cell.detailTextLabel.font = [UIFont fontWithName:@"Segoe WP Black" size:18];
		cell.detailTextLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:21.0/255.0 alpha:1.0];
	}
}

#pragma mark - Picker delegate methods

-(NSString*)pickerView:(MyPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [pickerView.source objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if ([pickerView isEqual: agePickerView]) {
		age.text = [NSString stringWithFormat:@"%d",row + 1];
		age.enabled = FALSE;
	} else {
		sex.text = row? @"Female" : @"Male";
		sex.enabled = FALSE;
	}
}
#pragma mark - Textfield delegate methods

/* IMPLEMENT NEXT ON KEYBOARD FOR NEXT TEXTFIELD */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
	EditCell *nextCell = (EditCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:(textField.tag % 3) inSection:(textField.tag / 3)]];
	if ([nextCell.reuseIdentifier isEqualToString:@"EditCell"]) {
		[nextCell.field becomeFirstResponder];
	} else {
		AboutMeCell *aboutMeCell = (AboutMeCell*)nextCell;
		[aboutMeCell.textView becomeFirstResponder];
	}
    return YES;
}

/* SAVE ENTERED FIELDS INTO INFO DICTIONARY */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	switch (textField.tag) {
		case 1:
			if(username.text.length > 0) [enteredInfo setValue:username.text forKey:@"username"];
			break;
		case 2:
			if(password.text.length > 0)[enteredInfo setValue:password.text forKey:@"password"];
			break;
		case 3:
			if(reEnter.text.length > 0)[enteredInfo setValue:reEnter.text forKey:@"reEnter"];
			break;
		case 4:
			if(age.text.length > 0)[enteredInfo setValue:age.text forKey:@"age"];
			break;
		case 5:
			if(sex.text.length > 0)[enteredInfo setValue:sex.text forKey:@"sex"];
			break;
		default:
			break;
	}
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	return (textField.text.length > 11) ? NO : YES;
}

#pragma mark - TextView delegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string {
    NSUInteger newLength = [textView.text length] + [string length] - range.length;
    return (newLength > 90) ? NO : YES;
}

#pragma mark - My methods

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(EditCell*)sender{
	if ([@"ShowAutoComp" compare:segue.identifier] == NSOrderedSame) {
		AutoCompScreen* autoCompScreen = segue.destinationViewController;
		autoCompScreen.title = sender.textLabel.text;
		switch (sender.tag) {
			case 0:
				autoCompScreen.searchBar.placeholder = @"Enter Country";
				autoCompScreen.tag = 0;
				autoCompScreen.listContent = dataSource.countries;
				break;
			case 1:
				autoCompScreen.searchBar.placeholder = @"Enter State";
				autoCompScreen.tag = 1;
				autoCompScreen.listContent = dataSource.states;
				break;
			case 2:
				autoCompScreen.searchBar.placeholder = @"Enter City";
				autoCompScreen.tag = 2;
				autoCompScreen.listContent = dataSource.cities;
				break;
			case 3:
				autoCompScreen.searchBar.placeholder = @"Enter School";
				autoCompScreen.tag = 3;
				autoCompScreen.listContent = dataSource.schools;
				break;
			default:
				break;
		}
		autoCompScreen.delegate = self;
	}
}

/* SAVE AND SET LABELS WITH CHOSEN COUNTRY, STATE, CITY, SCHOOL */
-(void)autoCompScreenDismissed:(NSString*)string tag:(NSInteger)tag
{
	UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tag inSection:2]];
	cell.detailTextLabel.text = string;
	switch (tag) {
		case 0:
			if(country.text.length > 0)[enteredInfo setValue:country.text forKey:@"country"];
			break;
		case 1:
			if(state.text.length > 0)[enteredInfo setValue:state.text forKey:@"state"];
			break;
		case 2:
			if(city.text.length > 0)[enteredInfo setValue:city.text forKey:@"city"];
			break;
		case 3:
			if(school.text.length > 0)[enteredInfo setValue:school.text forKey:@"school"];
			break;
		default:
			break;
	}
}

-(IBAction)btnDoneTapped:(id)sender{
	UIAlertView* alert = [UIAlertView alloc];
	if (username.text.length < 4) {
		[[alert initWithTitle:nil message:@"Username must be at least 4 characters" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil] show];
		// - check username already taken
	} else if (password.text.length < 4){
		[[alert initWithTitle:nil message:@"Password must be at least 4 characters" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil] show];
	} else if ([password.text compare:reEnter.text] != 0) {
		[[alert initWithTitle:nil message:@"Re-entered password does not match Password" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil] show];
	} else if (!([enteredInfo valueForKey:@"age"] && [enteredInfo valueForKey:@"sex"] && [enteredInfo valueForKey:@"country"] && [enteredInfo valueForKey:@"state"] && [enteredInfo valueForKey:@"city"] && [enteredInfo valueForKey:@"school"])){
		[[alert initWithTitle:nil message:@"All required fields must be completed" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil] show];
	} else {
		//salt the password
		NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", password.text, kSalt];
		//prepare the hashed storage
		NSString* hashedPassword = nil;
		unsigned char hashedPasswordData[CC_SHA1_DIGEST_LENGTH];
		//hash the pass
		NSData *data = [saltedPassword dataUsingEncoding: NSUTF8StringEncoding];
		if (CC_SHA1([data bytes], [data length], hashedPasswordData)) {
			hashedPassword = [[NSString alloc] initWithBytes:hashedPasswordData length:sizeof(hashedPasswordData) encoding:NSASCIIStringEncoding];
		} else { [UIAlertView error:@"Password can't be sent"]; return; }
		
		NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"register", @"command", enteredInfo, @"userInfo", hashedPassword, @"password", userPhoto, @"file", nil];
		
		//make the call to the web API
		[[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
			//result returned
			NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
			if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"IdUser"] intValue]>0) {
				[self dismissViewControllerAnimated:NO completion:nil];
				if([self.doneRegisteringDelegate respondsToSelector:@selector(doneRegistering:password:)])
					[self.doneRegisteringDelegate doneRegistering:[enteredInfo objectForKey:@"username"] password:[enteredInfo objectForKey:@"password"]];
			} else {
				//error
				[UIAlertView error:[json objectForKey:@"error"]];
			}
		}];

	}
}

- (void)viewDidUnload {
	[self setBtnDone:nil];
	[super viewDidUnload];
}
@end
