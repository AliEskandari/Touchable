//
//  StreamPhotoScreen.m
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "StreamPhotoScreen.h"
#import "API.h"

@implementation StreamPhotoScreen

@synthesize IdPhoto;
@synthesize IdUser;

-(void)viewDidLoad {
	API* api = [API sharedInstance];
	//load the caption of the selected photo
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command", IdPhoto,@"IdPhoto", nil] onCompletion:^(NSDictionary *json) {
		//show the text in the label
		NSArray* list = [json objectForKey:@"result"];
		NSDictionary* photo = [list objectAtIndex:0];
		lblTitle.text = [photo objectForKey:@"title"];
	}];
	//load the big size photo
	NSURL* imageURL = [api urlForImageWithId:IdPhoto isThumb:NO];
	[photoView setImageWithURL: imageURL];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(IBAction)btnTouchDontTouchTapped:(UIButton *)sender{
	//check whether it's a login or register
	NSString *update_field = (sender.tag==1)? @"touch_cnt": @"dont_cnt";

	API* api = [API sharedInstance];
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"update", @"command",update_field, @"field", IdUser, @"IdUser", nil] onCompletion:^(NSDictionary *json){
		sender.titleLabel.text = @"Done";
	}];
}


@end
