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
	__block NSMutableDictionary *profData;
	UIButton* touchMe;
	UIButton* dontTouchMe;
	ProPicView* proPicView;
	UISlider *likes;
    UILabel *ageLabel;
    UILabel *sexLabel;
	UILabel *aboutMeLabel, *aboutMeTextLabel;
    UILabel *schoolLabel;
    UILabel *locationLabel;
    UILabel *profileAge;
    UILabel *profileSex;
    UILabel *profileSchool;
    UILabel *profileLocation;
    UIView *line;
	float touchCnt;
	float dontCnt;
	float denominator, ratio;
	
	BOOL didChangeMind, firstInteraction;
}

@synthesize ProfileId;
@synthesize interactionType;
@synthesize index;
@synthesize interactionDelegate;

-(void)viewDidLoad {
	[super viewDidLoad];
	
	if ([interactionType isEqual:(id)[NSNull null]]) interactionType = 0;
	didChangeMind = NO;
	firstInteraction = YES;
	
	profileView = (UIScrollView *)self.view;
    profileView.contentSize=CGSizeMake(320,960);
	
	proPicView = [[ProPicView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
	likes = [[UISlider alloc] initWithFrame:CGRectMake(5, 275, 290, 10)];
	touchMe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	dontTouchMe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	aboutMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 380, 140, 30)];
	aboutMeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 415, 240, 65)];
    
    //initialize age sex school and location
    ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 505, 140, 30)];
    sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 530, 140, 30)];
    schoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 555, 140, 30)];
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 580, 140, 30)];
	
	[profileView addSubview:ageLabel];
	[profileView addSubview:sexLabel];
	[profileView addSubview:schoolLabel];
	[profileView addSubview:locationLabel];
    
    ageLabel.text = @"age";
    sexLabel.text = @"sex";
    schoolLabel.text = @"school";
    locationLabel.text = @"location";
    
    ageLabel.textColor =
    sexLabel.textColor =
    schoolLabel.textColor =
    locationLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:84.0/255.0 blue:25.0/255.0 alpha:1.0];
    
    ageLabel.font =
    sexLabel.font =
    schoolLabel.font =
	locationLabel.font = [UIFont fontWithName:@"Segoe WP Black" size:18];
    
    ageLabel.backgroundColor =
    sexLabel.backgroundColor =
    schoolLabel.backgroundColor =
    locationLabel.backgroundColor = [UIColor clearColor];
    
    profileAge = [[UILabel alloc] initWithFrame:CGRectMake(52, 505, 140, 30)];
    profileSex = [[UILabel alloc] initWithFrame:CGRectMake(52, 530, 140, 30)];
    profileSchool = [[UILabel alloc] initWithFrame:CGRectMake(78, 557, 240, 30)];
    profileLocation = [[UILabel alloc] initWithFrame:CGRectMake(92, 582, 226, 30)];
    
	[profileView addSubview:profileAge];
	[profileView addSubview:profileSex];
	[profileView addSubview:profileSchool];
	[profileView addSubview:profileLocation];
    
    profileAge.text = @"age";
    profileSex.text = @"sex";
    profileSchool.text = @"school";
    profileLocation.text = @"location";
    
    profileAge.textColor =
    profileSex.textColor =
    profileSchool.textColor =
    profileLocation.textColor = [UIColor colorWithRed:44.0/255.0 green:44.0/255.0 blue:43.0/255.0 alpha:1.0];
    
    profileAge.font =
    profileSex.font = [UIFont fontWithName:@"Segoe WP" size:18];
    profileSchool.font =
	profileLocation.font = [UIFont fontWithName:@"Segoe WP" size:13];
    
    profileAge.backgroundColor =
    profileSex.backgroundColor =
    profileSchool.backgroundColor =
    profileLocation.backgroundColor = [UIColor clearColor];
    
	line = [[UILabel alloc] initWithFrame:CGRectMake(20, 620, 280, 1)];
    line.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:44.0/255.0 blue:43.0/255.0 alpha:1.0];
	[profileView addSubview:line];
	
	if (interactionType) {
		firstInteraction = NO;
		switch ([interactionType integerValue]) {
			case 1: touchMe.enabled = NO; break;
			case 2: dontTouchMe.enabled = NO;
		}
		[proPicView setProPicFilterType:interactionType];
	}

	// load the big size photo and add to view
	NSURL* imageURL = [[API sharedInstance] urlForImageWithId:ProfileId isThumb:NO];
	AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest: [NSURLRequest requestWithURL:imageURL] success:^(UIImage *image) {
		//add it to the view
		[proPicView setImage:image];
	}];
	NSOperationQueue* queue = [[NSOperationQueue alloc] init];
	[queue addOperation:imageOperation];
	
	proPicView.layer.shadowColor = [UIColor blackColor].CGColor;
	proPicView.layer.shadowOpacity = 0.3;
	proPicView.layer.shadowRadius = 5;
	proPicView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
	
	[profileView addSubview:proPicView];
	
	// load slider bar onto profile pic
	likes.minimumValue = 0;
	likes.maximumValue = 1;
    UIImage *maxCap = [[UIImage imageNamed:@"orangeMaxCap2.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
    UIImage *minCap = [[UIImage imageNamed:@"blueMinCap2.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
    
    UIImage *thumb = [UIImage imageNamed:@"thumb4.png"];
    
    [likes setMinimumTrackImage:minCap forState:0];
    [likes setThumbImage:thumb forState:0];
    [likes setMaximumTrackImage:maxCap forState:0];
	
	[proPicView addSubview:likes];
	
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
	aboutMeLabel.backgroundColor = [UIColor clearColor];
	aboutMeLabel.text = @"AboutMe";
	aboutMeLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:30];
	[profileView addSubview:aboutMeLabel];
	
	aboutMeTextLabel.numberOfLines = 3;
	aboutMeTextLabel.lineBreakMode = UILineBreakModeWordWrap;
	aboutMeTextLabel.backgroundColor = [UIColor clearColor];
	aboutMeTextLabel.font = [UIFont fontWithName:@"Segoe WP Light" size:15];
	[profileView addSubview:aboutMeTextLabel];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark My methods -

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	API* api = [API sharedInstance];
	
	// get the selected photo's profile data
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"getProfile", @"command", [[[API sharedInstance] user] objectForKey:@"IdUser"], @"IdUser", ProfileId, @"ProfileId", nil] onCompletion:^(NSDictionary *json) {
		// show username in title
		profData = [[json objectForKey:@"result"] objectAtIndex:0];
		self.title = [profData objectForKey:@"username"];
		
		touchCnt = [[profData objectForKey:@"touch_cnt"] floatValue];
		dontCnt = [[profData objectForKey:@"dont_cnt"] floatValue];
		ratio = .5;
		if ((denominator = (touchCnt + dontCnt)) != 0) ratio = touchCnt/denominator;
		[likes setValue:ratio animated:YES];
		
        profileAge.text = [NSString stringWithFormat:@"%d",[[profData objectForKey:@"age"] intValue]];
        profileSex.text = [profData objectForKey:@"sex"];
        profileSchool.text = [profData objectForKey:@"school"];
        profileLocation.text = [NSString stringWithFormat:@"%@, %@, %@",
                                [profData objectForKey:@"city"],
                                [profData objectForKey:@"state"],
                                [profData objectForKey:@"country"]];
		if ((aboutMeTextLabel.text = [profData objectForKey:@"aboutMe"]).length == 0) aboutMeTextLabel.text = @"This person has not entered an About Me.";
		[aboutMeTextLabel sizeToFit];
		
	}];
}

-(IBAction)btnTouchDontTouchTapped:(UIButton *)sender{
	sender.enabled = FALSE;
	if (sender.tag) {
		dontTouchMe.enabled = TRUE;
		[proPicView setProPicFilterType:[NSNumber numberWithInteger:1]];
		[likes setValue:((touchCnt + 1) /(touchCnt + 1 + dontCnt)) animated:YES];
		if ([interactionType integerValue] == 2) didChangeMind = 1;
		else didChangeMind = 0;
	} else {
		touchMe.enabled = TRUE;
		[proPicView setProPicFilterType:[NSNumber numberWithInteger:2]];
		[likes setValue:(touchCnt/(touchCnt + 1 + dontCnt)) animated:YES];
		if ([interactionType integerValue] == 1) didChangeMind = 1;
		else didChangeMind = 0;
	}
}

-(void)viewWillDisappear:(BOOL)animated{
	if ((firstInteraction || didChangeMind) && (!touchMe.enabled || !dontTouchMe.enabled)){
		NSNumber *updateType = [NSNumber numberWithInteger:(!touchMe.enabled) ? 1 : 2]; // 1 = "touch me" : 2 = "dont touch me"
		API* api = [API sharedInstance];
		[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"interaction", @"command", updateType, @"interactionType", ProfileId, @"subjectId", [[api user] objectForKey:@"IdUser"], @"judgeId", [NSNumber numberWithBool:didChangeMind], @"didChangeMind", nil] onCompletion:^(NSDictionary *json){
			if ([interactionDelegate respondsToSelector:@selector(didInteractionType:atIndex:)]) {
				[interactionDelegate didInteractionType:updateType atIndex:index];
			}
			[super viewWillDisappear:animated];
		}];
	}
}

@end
