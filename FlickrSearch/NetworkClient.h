//
//  NetworkClient.h
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "Constants.h"
#import "SearchResult.h"

@interface NetworkClient : AFHTTPSessionManager

+(void)searchForPhotoswithCompletionBlock:(void (^)(NSArray *results, NSError *error))block;
+(void)getMoreDetailsFor:(SearchResult *)photo withCompletionBlock:(NSString *)s;
@end
