//
//  RandomizeProfileScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 1/14/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "RandomProfileScreen.h"

@interface RandomProfileScreen () {
	NSInteger ProfileId;
}

@end

@implementation RandomProfileScreen

@synthesize proPic;

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
	[self showRandomProfile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setProPic:nil];
	[self setTouchMeBtn:nil];
	[self setDontBtn:nil];
	[super viewDidUnload];
}
- (IBAction)btnTouchDontTouchTapped:(UIButton*)sender {
		NSString *update_field = (!sender.tag) ? @"touch_cnt": @"dont_cnt";
		API* api = [API sharedInstance];
		[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"interaction", @"command", update_field, @"field", [NSNumber numberWithInteger:ProfileId], @"IdUser", nil] onCompletion:^(NSDictionary *json){
			[self showRandomProfile];
		}];
}

-(void)showRandomProfile
{
	[[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"random", @"command", nil] onCompletion:^(NSDictionary *json) {
		if (![json objectForKey:@"error"]) {
			NSDictionary *result= [json objectForKey:@"result"][0];
			ProfileId = [[result objectForKey:@"IdUser"] integerValue];
			self.title = [result objectForKey:@"username"];
			
			NSURL* imageURL = [[API sharedInstance] urlForImageWithId:[NSNumber numberWithInteger:ProfileId] isThumb:NO];
			AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest: [NSURLRequest requestWithURL:imageURL] success:^(UIImage *image) {
				//add it to the view
				[proPic setImage:image];
			}];
			NSOperationQueue* queue = [[NSOperationQueue alloc] init];
			[queue addOperation:imageOperation];
			
		} else {
			[UIAlertView error:[json objectForKey:@"error"]];
		}
	}];
}

@end
