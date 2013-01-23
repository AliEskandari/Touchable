//
//  PeopleScreen.m
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "PeopleScreen.h"
#import "API.h"
#import "PhotoView.h"
#import "ProfileScreen.h"

@interface PeopleScreen(private)

-(void)refreshStream;
-(void)showStream:(NSArray*)stream;

@end

@implementation PeopleScreen {
	NSMutableArray *filters;
	NSMutableArray* streamData;
}

#pragma mark - View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = btnFilter;
	[self refreshStream];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)refreshStream {
    //just call the "stream" command from the web API
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command",[[[API sharedInstance] user] objectForKey:@"IdUser"], @"IdUser", nil] onCompletion:^(NSDictionary *json) {
		//got stream
		streamData = [NSMutableArray arrayWithArray:[json objectForKey:@"result"]];
		[self showStream:[json objectForKey:@"result"]];
		filters = [json objectForKey:@"filters"];
	}];
}

-(void)showStream:(NSArray*)stream {
    // 1 remove old photos
    for (UIView* view in listView.subviews) {
        [view removeFromSuperview];
    }
    // 2 add new photo views
    for (int i = 0; i < [stream count]; i++) {
        NSDictionary* photo = [stream objectAtIndex:i];
        PhotoView* photoView = [[PhotoView alloc] initWithIndex:i andData:photo];
        photoView.delegate = self;
        [listView addSubview: photoView];
    }    
    // 3 update scroll list's height
    int listHeight = ([stream count]/4 + 1)*(kThumbSide+kPadding);
	[listView setContentSize:CGSizeMake(320, listHeight)];
    [listView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
}

//photo selected - show it full screen
-(void)didSelectPhoto:(PhotoView*)sender {
	
	/*
	 Perfroms segue to Full Size photo view, and sets the "sender" to
	 the Selected Photo's obj tag.This was set to the IdPhoto of the photo when
	 it was initialized in PhotoView.m.
	*/
	
    [self performSegueWithIdentifier:@"ShowProfile" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(PhotoView *)sender {
    if ([@"ShowProfile" compare: segue.identifier]==NSOrderedSame) {
        ProfileScreen* profileScreen = segue.destinationViewController;
		profileScreen.photoView = sender;
}
	
	if ([@"ShowFilter" compare: segue.identifier]==NSOrderedSame) {
	FilterNavController *navigationController = segue.destinationViewController;
		navigationController.filterList = [NSMutableArray arrayWithArray:filters];
		navigationController.filterScreenDismissedDelegate = self;
    }
}

-(IBAction)btnFilterTapped:(id)sender {
	[self performSegueWithIdentifier:@"ShowFilter" sender:nil];
}

-(void)filterScreenDismissed {
	[self refreshStream];
}

@end
