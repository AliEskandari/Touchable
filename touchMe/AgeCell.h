//
//  AgeCell.h
//  touchMe
//
//  Created by Ali Eskandari on 1/8/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UITextField *age1TextField;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property (strong, nonatomic) IBOutlet UITextField *age2TextField;

@end
