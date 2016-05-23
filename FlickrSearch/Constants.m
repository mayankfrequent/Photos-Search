//
//  Constants.m
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "Constants.h"

NSString * const APIKey = @"9cbbee840e46c7da17cf3afd946e9b6d";
NSString * const BaseUrl = @"https://api.flickr.com/services/rest/";

NSString * const PhotoSearch = @"flickr.photos.search";
NSString * const RecentPhotos = @"flickr.photos.getRecent";
NSInteger const PerPageCount = 150;
NSInteger const PaginationMargin = 50;

NSInteger const ApplicationErrorNILKeyCode = 1600;
NSInteger const ApplicationErrorParseResponseKeyCode = 1601;

@implementation Constants

@end
