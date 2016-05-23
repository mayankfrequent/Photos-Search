//
//  ResponseHandler.m
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "ResponseHandler.h"
#import "SearchCriteria.h"
@implementation ResponseHandler
+(NSArray<SearchResult *> *)parseSearchResults:(id)response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        SearchCriteria *criteria = [SearchCriteria sharedObject];
        criteria.totalNumberOfPages = 2;//[[((NSDictionary *)response) valueForKeyPath:@"photos.pages"] unsignedIntegerValue];
        
        NSArray *photoCollection = [((NSDictionary *)response) valueForKeyPath:@"photos.photo"];
        NSMutableArray *results = [NSMutableArray array];
        for (NSDictionary *photo in photoCollection) {
            SearchResult *result = [[SearchResult alloc] initWithAttributes:photo];
            [results addObject:result];
        }
        
        return results;
    }
    
    return nil;
}
@end
