//
//  AutoCompleteTableView.h
//  touchMe
//
//  Created by Ali Eskandari on 12/31/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

// define the delegate protocol
@protocol AutoCompleteTableViewDelegate <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface AutoCompleteTableView : UITableView <UITableViewDataSource> 

@property NSMutableArray* data;
@property NSMutableArray* filtered;
@property (assign, nonatomic) id<AutoCompleteTableViewDelegate> delegate;

@end
