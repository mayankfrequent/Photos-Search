//
//  NetworkClient.m
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "NetworkClient.h"
#import "RequestFactory.h"
#import "ResponseHandler.h"

@implementation NetworkClient
+ (instancetype)sharedClient {
    static NetworkClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetworkClient alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
        
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _sharedClient.requestSerializer.timeoutInterval = 20;
    });
    
    return _sharedClient;
}


+(void)searchForPhotoswithCompletionBlock:(void (^)(NSArray *results, NSError *error))block{
    
    NSDictionary *parameters = [RequestFactory getPhotos];
    
    if (parameters) {
        [[NetworkClient sharedClient] GET:@"" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *results = [ResponseHandler parseSearchResults:responseObject];
            if (results) {
                if (block) {
                    block(results,nil);
                }
            } else {
                NSError *myError = [NSError errorWithDomain:@"Required value nil" code:ApplicationErrorNILKeyCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:ApplicationErrorNILKeyCode] forKey:@"code"],AFNetworkingOperationFailingURLResponseDataErrorKey, nil]];
                if (block) {
                    block(nil, myError);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error %@",error);
            NSLog(@"Request Failed With Reason %@",error.description);
            NSLog(@"Request Failed With Reason code %ld",(long)error.code);
        }];
    }
    else{
        NSError *myError = [NSError errorWithDomain:@"Required value nil" code:ApplicationErrorNILKeyCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:ApplicationErrorNILKeyCode] forKey:@"code"],AFNetworkingOperationFailingURLResponseDataErrorKey, nil]];
        if (block) {
            block(nil, myError);
        }
    }
    
    
}

@end
