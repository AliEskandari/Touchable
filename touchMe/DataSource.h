//
//  DataSource.h
//  touchMe
//
//  Created by Ali Eskandari on 12/31/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

@property (strong, nonatomic) NSMutableArray* states;
@property (strong, nonatomic) NSMutableArray* ages;
@property (strong, nonatomic) NSMutableArray* sexes;
@property (strong, nonatomic) NSMutableArray* countries;
@property (strong, nonatomic) NSMutableArray* schools;
@property (strong, nonatomic) NSMutableArray* cities;
@property (strong, nonatomic) NSMutableArray* filters;

@end
