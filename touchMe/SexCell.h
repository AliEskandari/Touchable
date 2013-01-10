//
//  SexCell.h
//  touchMe
//
//  Created by Ali Eskandari on 1/8/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)segmentValueChanged:(id)sender;
@end
