//
//  RecentActivityScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 1/21/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "RecentActivityScreen.h"

@interface RecentActivityScreen () {
	NSMutableArray *displayArray;
}

@end

@implementation RecentActivityScreen

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

    self.tableView.dataSource = self;
	self.tableView.delegate = self;
	
	// Pull profile data of recent interactions
	[[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"recentActivity", @"command", [[[API sharedInstance] user] objectForKey:@"IdUser"], @"IdUser", nil] onCompletion:^(NSDictionary *json) {
		if (![json objectForKey:@"error"]) {
			displayArray = [NSMutableArray arrayWithArray:[json objectForKey:@"result"]];
			[self.tableView reloadData];
		} else {
			[UIAlertView error:@"Database connection failed"];
		}
	}];
}

- (void)viewDidAppear:(BOOL)animated {
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [displayArray count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"ProfileCell";
	ProfileCell* profileCell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (profileCell == nil) {
		profileCell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
	}
	return profileCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIView *selectionColor = [[UIView alloc] init];
	selectionColor.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(51.0/255.0) blue:(21.0/255.0) alpha:1];
	cell.selectedBackgroundView = selectionColor;
	
	cell.backgroundColor = [UIColor colorWithRed:(227.0/255.0) green:(227.0/255.0) blue:(227.0/255.0) alpha:1];
	
	ProfileCell *profileCell = (ProfileCell*) cell;
	
	NSInteger ProfileId = [[displayArray[indexPath.row] objectForKey:@"subjectId"] integerValue];
	NSURL* imageURL = [[API sharedInstance] urlForImageWithId:[NSNumber numberWithInteger:ProfileId] isThumb:YES];
	AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest: [NSURLRequest requestWithURL:imageURL] success:^(UIImage *image) {
		[profileCell.proPicView setImage:image];
		[profileCell.proPicView setProPicFilterType:[displayArray[indexPath.row] objectForKey:@"type"]];
		profileCell.proPicView.contentMode = UIViewContentModeScaleAspectFit;
	}];
	NSOperationQueue* queue = [[NSOperationQueue alloc] init];
	[queue addOperation:imageOperation];
	
	profileCell.usernameLabel.font = [UIFont fontWithName:@"Segoe WP Black" size:14];
	profileCell.timeStampLabel.font = [UIFont fontWithName:@"Segoe WP Black" size:16];
	
	profileCell.usernameLabel.text = [displayArray[indexPath.row] objectForKey:@"username"];
	profileCell.timeStampLabel.text = [displayArray[indexPath.row] objectForKey:@"timeStamp"];
}

#pragma mark Table View Delegate methods -

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[aTableView deselectRowAtIndexPath:indexPath animated:NO];
	[self performSegueWithIdentifier:@"ShowProfile" sender:[NSNumber numberWithInteger:indexPath.row]];
}

#pragma mark My methods -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber *)sender {
    if ([@"ShowProfile" compare: segue.identifier]==NSOrderedSame) {
        ProfileScreen* profileScreen = segue.destinationViewController;
		NSDictionary* cellData = displayArray[[sender integerValue]];
		profileScreen.ProfileId = [cellData objectForKey:@"subjectId"];
		profileScreen.interactionType = [cellData objectForKey:@"type"];
		profileScreen.index = [sender integerValue];
		profileScreen.interactionDelegate = self;
    }
}

- (void)didInteractionType:(NSInteger)type atIndex:(NSInteger)index {
	[[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"recentActivity", @"command", [[[API sharedInstance] user] objectForKey:@"IdUser"], @"IdUser", nil] onCompletion:^(NSDictionary *json) {
		if (![json objectForKey:@"error"]) {
			displayArray = [NSMutableArray arrayWithArray:[json objectForKey:@"result"]];
			[self.tableView reloadData];
		} else {
			[UIAlertView error:@"Database connection failed"];
		}
	}];
}

@end
