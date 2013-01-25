//
//  ProPicView.h
//  touchMe
//
//  Created by Ali Eskandari on 1/23/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProPicView : UIImageView
-(id)initWithFrame:(CGRect)frame Image:(UIImage *)image filterType:(NSNumber*)type;
-(void)setProPicFilterType:(NSNumber*)type;
@end
