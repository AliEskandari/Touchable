//
//  RandomizeScreen.m
//  touchMe
//
//  Created by Ali Eskandari on 1/14/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import "RandomizeScreen.h"

@interface RandomizeScreen ()

@end

@implementation RandomizeScreen

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

- (void)viewDidUnload {
    [self setRandomizeLabel:nil];
    [self setChangeFiltersBtn:nil];
    [self setRandomizeBtn:nil];
    [super viewDidUnload];
}
- (IBAction)randomizeBtnTapped:(id)sender {
	[self performSegueWithIdentifier:@"ShowRandomProfile" sender:nil];
}

- (IBAction)filtersBtnTapped:(id)sender {
}
@end
