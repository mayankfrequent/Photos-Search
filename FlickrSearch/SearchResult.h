//
//  SearchResult.h
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject
@property (nonatomic, copy) NSString *photoId;
@property (nonatomic, copy) NSString *ownerId;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, copy) NSString *farm;
@property (nonatomic, copy) NSString *photoTitle;
@property (readonly, nonatomic, unsafe_unretained) NSURL *imageUrl;
@property (readonly, nonatomic, unsafe_unretained) NSURL *thumbnailUrl;
- (instancetype)initWithAttributes:(NSDictionary *)attributes;
@end
