//
//  SearchResult.m
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.photoId = [attributes valueForKeyPath:@"id"];
    self.ownerId = [attributes valueForKeyPath:@"owner"];
    self.secret = [attributes valueForKeyPath:@"secret"];
    self.farm = [attributes valueForKeyPath:@"farm"];
    self.server = [attributes valueForKeyPath:@"server"];
    self.photoTitle = [attributes valueForKeyPath:@"title"];
    
    return self;
}
-(NSURL *)imageUrl{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_b.jpg",self.farm,self.server,self.photoId,self.secret]];
}
-(NSURL *)thumbnailUrl{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_t.jpg",self.farm,self.server,self.photoId,self.secret]];
}
@end
