//
//  AutoCompScreen.h
//  touchMe
//
//  Created by Ali Eskandari on 12/31/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AutoCompScreenDelegate <NSObject>
-(void)autoCompScreenDismissed:(NSString*)string tag:(NSInteger)tag;
@end


@interface AutoCompScreen : UIViewController <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic) NSInteger tag;

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (assign, nonatomic) id<AutoCompScreenDelegate> delegate;

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText;
@end
