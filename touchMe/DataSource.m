//
//  DataSource.m
//  touchMe
//
//  Created by Ali Eskandari on 12/31/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

@synthesize ages;
@synthesize states;
@synthesize countries;
@synthesize sexes;
@synthesize schools;
@synthesize cities;
@synthesize filters;


#pragma mark - init
//intialize the API class with the deistination host name

-(DataSource*)init {
    //call super init
    self = [super init];
    if (self != nil) {
        //initialize the object
		
        ages = [[NSMutableArray alloc] init];
		for (int x=1; x<=100; x++) {
			NSString *ageString = [NSString stringWithFormat:@"%d",x];
			[ages addObject:ageString];
		}
		
		states = [[NSMutableArray alloc] initWithObjects:@"Alabama", @"Alaska",@"Arizona",@"Arkansas",@"California",@"Colorado",@"Connecticut",@"Delaware",@"Florida", @"Georgia",@"Hawaii",@"Idaho",@"Illinois",@"Indiana",@"Iowa",@"Kansas",@"Kentucky",@"Louisiana",@"Maine",@"Maryland",@"Massachusetts",@"Michigan",@"Minnesota",@"Mississippi",@"Missouri",@"Montana",@"Nebraska",@"Nevada",@"New Hampshire",@"New Jersey",
				  @"New Mexico",@"New York",@"North Carolina",@"North Dakota",@"Ohio",@"Oklahoma",@"Oregon",@"Pennsylvania",@"Rhode Island",@"South Carolina",
				  @"South Dakota",@"Tennessee",@"Texas",@"Utah",@"Vermont",@"Virginia",@"Washington",@"West Virginia",@"Wisconsin",@"Wyoming",nil];
		
		countries = [[NSMutableArray alloc] initWithObjects:@"United States", @"Canada",nil];
		
		sexes = [[NSMutableArray alloc] initWithObjects:@"Male",@"Female",nil];
		
		schools = [[NSMutableArray alloc] initWithObjects:@"University of Maryland, College Park",
				   @"Salisbury University",@"Montgomery College, Germantown Campus",nil];
		cities = [[NSMutableArray alloc] initWithObjects:@"Germantown",nil];
		
		filters = [[NSMutableArray alloc] initWithObjects:@"Sex", @"Age", @"Country", @"State", @"City", @"School", nil];
    }
    return self;
}



@end