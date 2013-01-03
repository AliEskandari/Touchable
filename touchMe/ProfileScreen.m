//
//  ProfileScreen.m
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "ProfileScreen.h"
#import "API.h"
#import "PhotoView.h"

@implementation ProfileScreen
{
	IBOutlet UIScrollView* profileView;
	UIButton* touchMe;
	UIButton* dontTouchMe;
	UIImageView* proPic;
	UITextField* aboutMe;
	NSDictionary *profData;
}

@synthesize IdUser;

-(void)viewDidLoad {
	[super viewDidLoad];
	profileView=(UIScrollView *)self.view;
    profileView.contentSize=CGSizeMake(320,960);
	
	API* api = [API sharedInstance];
	//load the profile data
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"getProfile", @"command", IdUser, @"IdUser", nil] onCompletion:^(NSDictionary *json) {
		//show username in title
		NSArray* list = [json objectForKey:@"result"];
		profData = [list objectAtIndex:0];
		self.title = [profData objectForKey:@"username"];
	}];
	
	//load the big size photo and add to view
	NSURL* imageURL = [api urlForImageWithId:IdUser isThumb:NO];
	proPic = [[UIImageView alloc] initWithFrame:CGRectMake( 10, 10, 300, 300)];
	[proPic setImageWithURL: imageURL];

	proPic.layer.shadowColor = [UIColor blackColor].CGColor;
	proPic.layer.shadowOpacity = 0.5;
	proPic.layer.shadowRadius = 5;
	proPic.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
	
	[profileView addSubview:proPic];
	
	// load uibuttons and add under profile pic
	touchMe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	touchMe.frame = CGRectMake(10, 320, 145, 45);
	[touchMe setBackgroundImage:[UIImage imageNamed:@"touch me.png"] forState:UIControlStateNormal];
	[touchMe setBackgroundImage:[UIImage imageNamed:@"touch me GRAYED.png"] forState:UIControlStateDisabled];
	touchMe.layer.shadowColor = [UIColor blackColor].CGColor;
	touchMe.layer.shadowOpacity = 0.5;
	touchMe.layer.shadowRadius = 5;
	touchMe.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
	[touchMe addTarget:self action:@selector(btnTouchDontTouchTapped:) forControlEvents:UIControlEventTouchUpInside];
	touchMe.tag = 1;
	[profileView addSubview:touchMe];
	
	dontTouchMe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	dontTouchMe.frame = CGRectMake(165, 320, 145, 45);
	[dontTouchMe setBackgroundImage:[UIImage imageNamed:@"dont touch me.png"] forState:UIControlStateNormal];
	[dontTouchMe setBackgroundImage:[UIImage imageNamed:@"dont touch me GRAYED.png"] forState:UIControlStateDisabled];
	dontTouchMe.layer.shadowColor = [UIColor blackColor].CGColor;
	dontTouchMe.layer.shadowOpacity = 0.5;
	dontTouchMe.layer.shadowRadius = 5;
	dontTouchMe.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
	[dontTouchMe addTarget:self action:@selector(btnTouchDontTouchTapped:) forControlEvents:UIControlEventTouchUpInside];
	[profileView addSubview:dontTouchMe];
	
	
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(IBAction)btnTouchDontTouchTapped:(UIButton *)sender{
	if (sender.tag) {
		sender.enabled = FALSE;
		dontTouchMe.enabled = TRUE;
		
	} else {
		sender.enabled = FALSE;
		touchMe.enabled = TRUE;
	}
}

-(void)viewWillDisappear:(BOOL)animated{
	if (!touchMe.enabled || !dontTouchMe.enabled){
		NSString *update_field = (!touchMe.enabled) ? @"touch_cnt": @"dont_cnt";
		API* api = [API sharedInstance];
		[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"update", @"command",update_field, @"field", IdUser, @"IdUser", nil] onCompletion:^(NSDictionary *json){}];
		[super viewWillDisappear:animated];
	}
}


@end
