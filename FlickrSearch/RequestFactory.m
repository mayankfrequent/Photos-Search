//
//  RequestFactory.m
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "RequestFactory.h"
#import "SearchCriteria.h"
@implementation RequestFactory
+(NSDictionary *)getPhotos{
    
    SearchCriteria *criteria  = [SearchCriteria sharedObject];
    
    if ( criteria.page<= 0) {
        return nil;
    }
    
    if (InfiniteScrollListHack) {
        if (criteria.totalNumberOfPages > 0 && criteria.totalNumberOfPages == criteria.page) {
            criteria.page = 1;
        }
    }
    else{
        if (criteria.totalNumberOfPages > 0 && criteria.totalNumberOfPages == criteria.page) {
            criteria.isLastPage = YES;
        }
    }
    
    switch (criteria.type) {
        case SearchTypeWithText:
            return @{@"method":PhotoSearch,
                     @"api_key":APIKey,
                     @"text":criteria.text,
                     @"page":@(criteria.page),
                     @"per_page":@(PerPageCount),
                     @"format":@"json",
                     @"nojsoncallback":@(1)};
            
        default:
            return @{@"method":RecentPhotos,
                     @"api_key":APIKey,
                     @"page":@(criteria.page),
                     @"per_page":@(PerPageCount),
                     @"format":@"json",
                     @"nojsoncallback":@(1)};
    }
    
    
}
@end
