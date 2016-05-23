//
//  Constants.h
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SearchType) {
    SearchTypeWithoutText = 0,
    SearchTypeWithText = 1
};

FOUNDATION_EXTERN NSString * const APIKey;
FOUNDATION_EXTERN NSString * const BaseUrl;
FOUNDATION_EXTERN NSString * const PhotoSearch;
FOUNDATION_EXPORT NSString * const RecentPhotos;
FOUNDATION_EXTERN NSInteger const PerPageCount;
FOUNDATION_EXTERN NSInteger const PaginationMargin;

FOUNDATION_EXTERN NSInteger const ApplicationErrorNILKeyCode;
FOUNDATION_EXTERN NSInteger const ApplicationErrorParseResponseKeyCode;

#define InfiniteScrollListHack 1

@interface Constants : NSObject

@end
