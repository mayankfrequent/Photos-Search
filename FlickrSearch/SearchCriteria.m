//
//  SearchCriteria.m
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "SearchCriteria.h"

@implementation SearchCriteria
+(instancetype)sharedObject{
    static SearchCriteria *_client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _client = [[SearchCriteria alloc] init];
    });
    
    return _client;
}

-(void)setType:(SearchType)type{
    _type = type;
    switch (_type) {
        case SearchTypeWithoutText:
            _page = 1;
            _totalNumberOfPages = 0;
            _text = nil;
            break;
        default:
            _page = 1;
            _totalNumberOfPages = 0;
            break;
    }
}

@end
