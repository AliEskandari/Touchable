//
//  RefreshScrollView.h
//  touchMe
//
//  Created by Ali Eskandari on 12/25/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	PullRefreshPulling = 0,
	PullRefreshNormal,
	PullRefreshLoading,
} PullRefreshState;

@protocol RefreshScrollViewDelegate;
@interface RefreshScrollView : UIView {
	

	PullRefreshState _state;
	
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
	
	
}

@property(nonatomic,assign) id <RefreshScrollViewDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)RefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)RefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)RefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol RefreshScrollViewDelegate <NSObject>
- (void)RefreshScrollViewDidTriggerRefresh:(RefreshScrollView*)view;
- (BOOL)RefreshScrollViewDataSourceIsLoading:(RefreshScrollView*)view;
@optional
- (NSDate*)RefreshScrollViewDataSourceLastUpdated:(RefreshScrollView*)view;
@end
