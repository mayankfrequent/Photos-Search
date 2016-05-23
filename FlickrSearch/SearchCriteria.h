//
//  SearchCriteria.h
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchCriteria : NSObject
+(instancetype)sharedObject;
@property (nonatomic, copy) NSString *text;
@property NSUInteger page;
@property NSUInteger totalNumberOfPages;
@property BOOL isLastPage;
@property (nonatomic) SearchType type;
@end
