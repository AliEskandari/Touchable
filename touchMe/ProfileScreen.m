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
	UISlider *likes;
    UILabel *ageLabel;
    UILabel *sexLabel;
    UILabel *schoolLabel;
    UILabel *locationLabel;
    UILabel *profileAge;
    UILabel *profileSex;
    UILabel *profileSchool;
    UILabel *profileLocation;
    UIView *line;
	float touchCnt;
	float dontCnt;
}

@synthesize IdUser;
@synthesize profData;
@synthesize aboutMeLabel;
@synthesize aboutMeTextLabel;

-(void)viewDidLoad {
	[super viewDidLoad];
	
	profileView = (UIScrollView *)self.view;
    profileView.contentSize=CGSizeMake(320,960);
	
	proPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
	likes = [[UISlider alloc] initWithFrame:CGRectMake(5, 275, 290, 10)];
	touchMe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	dontTouchMe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	aboutMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 380, 140, 30)];
	aboutMeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 415, 270, 65)];
		
	proPic.layer.shadowColor = [UIColor blackColor].CGColor;
	proPic.layer.shadowOpacity = 0.5;
	proPic.layer.shadowRadius = 5;
	proPic.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
	
	[profileView addSubview:proPic];
	
	// load the big size photo and add to view
	
	/*
	 NSURL* imageURL = [api urlForImageWithId:IdUser isThumb:NO];
	 [proPic setImageWithURL: imageURL];
	 */
	
	NSURL* imageURL = [[API sharedInstance] urlForImageWithId:IdUser isThumb:NO];
	AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest: [NSURLRequest requestWithURL:imageURL] success:^(UIImage *image) {
		//add it to the view
		[proPic setImage:image];
	}];
	NSOperationQueue* queue = [[NSOperationQueue alloc] init];
	[queue addOperation:imageOperation];
	
	// load slider bar onto profile pic
	likes.minimumValue = 0;
	likes.maximumValue = 1;
    UIImage *maxCap = [[UIImage imageNamed:@"orangeMaxCap2.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
    UIImage *minCap = [[UIImage imageNamed:@"blueMinCap2.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
    
    UIImage *thumb = [UIImage imageNamed:@"thumb4.png"];
    
    [likes setMinimumTrackImage:minCap forState:0];
    [likes setThumbImage:thumb forState:0];
    [likes setMaximumTrackImage:maxCap forState:0];
	
	[proPic addSubview:likes];
	
	// load uibuttons and add under profile pic
	touchMe.frame = CGRectMake(10, 320, 145, 45);
	[touchMe setBackgroundImage:[UIImage imageNamed:@"touch me.png"] forState:UIControlStateNormal];
	[touchMe setBackgroundImage:[UIImage imageNamed:@"touch me GRAYED.png"] forState:UIControlStateDisabled];
	touchMe.layer.shadowColor = [UIColor blackColor].CGColor;
	touchMe.layer.shadowOpacity = 0.3;
	touchMe.layer.shadowRadius = 5;
	touchMe.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
	[touchMe addTarget:self action:@selector(btnTouchDontTouchTapped:) forControlEvents:UIControlEventTouchUpInside];
	touchMe.tag = 1;
	[profileView addSubview:touchMe];
	
	dontTouchMe.frame = CGRectMake(165, 320, 145, 45);
	[dontTouchMe setBackgroundImage:[UIImage imageNamed:@"dont touch me.png"] forState:UIControlStateNormal];
	[dontTouchMe setBackgroundImage:[UIImage imageNamed:@"dont touch me GRAYED.png"] forState:UIControlStateDisabled];
	dontTouchMe.layer.shadowColor = [UIColor blackColor].CGColor;
	dontTouchMe.layer.shadowOpacity = 0.3;
	dontTouchMe.layer.shadowRadius = 5;
	dontTouchMe.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
	[dontTouchMe addTarget:self action:@selector(btnTouchDontTouchTapped:) forControlEvents:UIControlEventTouchUpInside];
	[profileView addSubview:dontTouchMe];
	
	//load aboutMe section
	//aboutMeLabel.layer.borderColor = [UIColor blackColor].CGColor;
	//aboutMeLabel.layer.borderWidth = 1;
	aboutMeLabel.backgroundColor = [UIColor clearColor];
	aboutMeLabel.text = @"AboutMe";
	aboutMeLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:30];
	[profileView addSubview:aboutMeLabel];
	
	//aboutMeTextLabel.layer.borderColor = [UIColor blackColor].CGColor;
	//aboutMeTextLabel.layer.borderWidth = 1;
	aboutMeTextLabel.numberOfLines = 3;
	aboutMeTextLabel.lineBreakMode = UILineBreakModeWordWrap;
	aboutMeTextLabel.backgroundColor = [UIColor clearColor];
	aboutMeTextLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:15];
	[profileView addSubview:aboutMeTextLabel];
    
    //Add additional information
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	API* api = [API sharedInstance];
	
	// get the selected photo's profile data
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"getProfile", @"command", IdUser, @"IdUser", nil] onCompletion:^(NSDictionary *json) {
		// show username in title
		profData = [[json objectForKey:@"result"] objectAtIndex:0];
		self.title = [profData objectForKey:@"username"];
		touchCnt = [[profData objectForKey:@"touch_cnt"] floatValue];
		dontCnt = [[profData objectForKey:@"dont_cnt"] floatValue];
		if ((aboutMeTextLabel.text = [profData objectForKey:@"aboutMe"]).length == 0) aboutMeTextLabel.text = @"This person has not entered an About Me.";
		[aboutMeTextLabel sizeToFit];
	}];
	
	float denominator, ratio = .5;
	if ((denominator = (touchCnt + dontCnt)) != 0) ratio = touchCnt/denominator;
	[likes setValue:ratio animated:YES];
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
		[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"interaction", @"command",update_field, @"field", IdUser, @"IdUser", nil] onCompletion:^(NSDictionary *json){}];
		[super viewWillDisappear:animated];
	}
}


@end
