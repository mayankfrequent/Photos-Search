//
//  GalleryCollectionViewCell.m
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "GalleryCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface GalleryCollectionViewCell ()

@property(nonatomic,weak) IBOutlet UIImageView *imageview;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@end

@implementation GalleryCollectionViewCell
-(void)setImageWithUrl:(NSURL *)url{
    [self.imageview setImage:nil];
    __weak typeof(self) weakSelf = self;
    
    [self.activityIndicatorView startAnimating];
    
    [self.imageview setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicatorView stopAnimating];
            [weakSelf.imageview setImage:image];
        });
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicatorView stopAnimating];
        });
    }];
}
@end
