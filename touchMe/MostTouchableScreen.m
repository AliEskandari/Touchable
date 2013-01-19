//
//  MostTouchableScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 1/14/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "MostTouchableScreen.h"

@interface MostTouchableScreen ()

@end

@implementation MostTouchableScreen

@synthesize source;
@synthesize displayArray;
@synthesize tabBar;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	tabBar.delegate = self;
	tableView.dataSource = self;
	tableView.delegate = self;
	
	// Pull profile data of top 50 users
	[[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"mostTouchable", @"command", nil] onCompletion:^(NSDictionary *json) {
		source = json;
		if (![[json objectForKey:@"All"] objectForKey:@"error"]) {
			displayArray = [[source objectForKey:@"All"] objectForKey:@"result"];
			[tableView reloadData];
		} else {
			[UIAlertView error:@"Database connection failed"];
		}
	}];
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setTableView:nil];
	[self setTabBar:nil];
	[super viewDidUnload];
}

#pragma mark Table View Data Source methods -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [displayArray count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"ProfileCell";
	ProfileCell* profileCell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (profileCell == nil) {
		profileCell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
	}
	
	NSInteger IdUser = [[displayArray[indexPath.row] objectForKey:@"IdUser"] integerValue];
	NSURL* imageURL = [[API sharedInstance] urlForImageWithId:[NSNumber numberWithInteger:IdUser] isThumb:YES];
	AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest: [NSURLRequest requestWithURL:imageURL] success:^(UIImage *image) {
		[profileCell.thumbView setImage:image];
		profileCell.thumbView.contentMode = UIViewContentModeScaleAspectFit;
	}];
	NSOperationQueue* queue = [[NSOperationQueue alloc] init];
	[queue addOperation:imageOperation];
	
	profileCell.usernameLabel.font = [UIFont fontWithName:@"Segoe WP Black" size:12];
	profileCell.numRankLabel.font = [UIFont fontWithName:@"Segoe WP Black" size:20];
	profileCell.numTouchMeLabel.font = [UIFont fontWithName:@"Segoe WP Black" size:16];
	
	profileCell.numRankLabel.text =[NSString stringWithFormat:@"%d", indexPath.row + 1];
	profileCell.usernameLabel.text = [displayArray[indexPath.row] objectForKey:@"username"];
	profileCell.numTouchMeLabel.text = [displayArray[indexPath.row] objectForKey:@"touch_cnt"];
	
	return profileCell;
	
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIView *selectionColor = [[UIView alloc] init];
	selectionColor.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(51.0/255.0) blue:(21.0/255.0) alpha:1];
	cell.selectedBackgroundView = selectionColor;
	
	cell.backgroundColor = [UIColor colorWithRed:(227.0/255.0) green:(227.0/255.0) blue:(227.0/255.0) alpha:1];
	
}

#pragma mark Table View Delegate methods -

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[aTableView deselectRowAtIndexPath:indexPath animated:NO];
	[self performSegueWithIdentifier:@"ShowProfile" sender:[displayArray[indexPath.row] objectForKey:@"IdUser"]];
}


#pragma mark TabBar delegate methods -

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	if (![[source objectForKey:item.title] objectForKey:@"error"]) {
		displayArray = [[source objectForKey:item.title] objectForKey:@"result"];
		[tableView reloadData];
	} else {
		[UIAlertView error:@"Database connection failed"];
	}
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber *)sender {
    if ([@"ShowProfile" compare: segue.identifier]==NSOrderedSame) {
        ProfileScreen* ProfileScreen = segue.destinationViewController;
		ProfileScreen.IdUser = sender;
    }
}

@end


