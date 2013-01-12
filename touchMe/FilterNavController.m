//
//  FilterNavController.m
//  touchMe
//
//  Created by Ali Eskandari on 1/11/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "FilterNavController.h"

@interface FilterNavController ()

@end

@implementation FilterNavController

@synthesize filterList;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
