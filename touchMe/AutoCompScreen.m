//
//  AutoCompScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 12/31/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "AutoCompScreen.h"

@interface AutoCompScreen ()

@end

@implementation AutoCompScreen

@synthesize searchBar;
@synthesize tableView;
@synthesize tag;

@synthesize listContent;
@synthesize filteredListContent;
@synthesize delegate;


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
	// Do any additional setup after loading the view.
	// create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
	searchBar.delegate = self;
	tableView.dataSource = self;
	tableView.delegate = self;
	
	
	[self.tableView reloadData];
	self.tableView.scrollEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setSearchBar:nil];
	[super viewDidUnload];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
	if (searchBar.text.length != 0)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.listContent count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	/*
	 If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
	 */
	NSString *label = nil;
	if ([searchBar.text length])
	{
		label = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        label = [self.listContent objectAtIndex:indexPath.row];
    }
	
	cell.textLabel.text = label;
	return cell;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [aTableView cellForRowAtIndexPath:indexPath];
	
	UIView *selectionColor = [[UIView alloc] init];
	selectionColor.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(61.0/255.0) blue:(41.0/255.0) alpha:1];
	cell.selectedBackgroundView = selectionColor;
	
	if([self.delegate respondsToSelector:@selector(autoCompScreenDismissed:tag:)])
	{
		
		[self.delegate autoCompScreenDismissed:cell.textLabel.text tag:tag];
		
	}
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Content Filtering

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (NSString *str in listContent)
	{
		NSRange strRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
		if (strRange.location != NSNotFound)
		{
			[self.filteredListContent addObject:str];
		}
		
	}
	[tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[searchBar resignFirstResponder];
}



@end
