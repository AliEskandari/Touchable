//
//  PhotoView.h
//  iReporter
//
//  Created by Fahim Farook on 9/6/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

//1 layout config
#define kThumbSide 80
#define kPadding 0

//2 define the thumb delegate protocol
@protocol PhotoViewDelegate <NSObject>
-(void)didSelectPhoto:(id)sender;
@end

//3 define the thumb view interface
@interface PhotoView : UIButton
@property (assign, nonatomic) id<PhotoViewDelegate> delegate;
@property (strong, nonatomic) NSNumber *IdUser;

-(id)initWithIndex:(int)i andData:(NSDictionary*)data;

@end
