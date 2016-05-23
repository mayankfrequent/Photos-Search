//
//  ResponseHandler.h
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResult.h"
@interface ResponseHandler : NSObject
+(NSArray<SearchResult *> *)parseSearchResults:(id)response;
@end
