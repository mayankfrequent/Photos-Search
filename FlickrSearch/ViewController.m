//
//  ViewController.m
//  FlickrSearch
//
//  Created by Mayank Shah on 23/05/16.
//  Copyright © 2016 Mayank Shah. All rights reserved.
//

#import "ViewController.h"
#import "NetworkClient.h"
#import "SearchCriteria.h"
#import "SearchResult.h"
#import "GalleryCollectionViewCell.h"
#import <IDMPhotoBrowser.h>

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.delegate = self;
    searchBar.placeholder = NSLocalizedString(@"Search Photos", nil);
    self.navigationItem.titleView = searchBar;
    // Do any additional setup after loading the view, typically from a nib.
    SearchCriteria *criteria  = [SearchCriteria sharedObject];
    criteria.type = SearchTypeWithoutText;
    [self loadImages];
}


-(void)loadImages{
    __weak typeof(self) weakSelf = self;
    
    [NetworkClient searchForPhotoswithCompletionBlock:^(NSArray *results, NSError *error) {
        NSLog(@"Count %lu",(unsigned long)[results count]);
        NSArray *previousArray = weakSelf.dataArray ?: [NSArray array];
        NSUInteger resultsSize = [previousArray count]; //data is the previous array of data
        weakSelf.dataArray = [previousArray arrayByAddingObjectsFromArray:results];
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        
        for (NSUInteger i = resultsSize; i < resultsSize + PerPageCount; i++) {
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
        });
    }];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 6 ) / 4;
    CGFloat height = width;
    
    return CGSizeMake(width,height);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCollectionViewCell *cell = (GalleryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCriteria *criteria = [SearchCriteria sharedObject];
    //Loaded Objects assumption - 150 objects are loaded everytime, this would fail if all objects are not loaded successfully... Need to look at this.. probably check if every objects is loaded correctly or not.. or maybe fake unsuccessful objects
    NSUInteger loadedCount = PerPageCount * criteria.page;
    if (!criteria.isLastPage && criteria.totalNumberOfPages > 0 && (loadedCount - PaginationMargin) == indexPath.row) {
        NSUInteger currentPage = criteria.page;
        criteria.page = ++currentPage;
        [self loadImages];
    }
}

-(void)configureCell:(GalleryCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    SearchResult *photo = [self.dataArray objectAtIndex:indexPath.row];
    [cell setImageWithUrl:photo.thumbnailUrl];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchResult *photo = [self.dataArray objectAtIndex:indexPath.row];
    
    IDMPhoto *photoLarge = [IDMPhoto photoWithURL:photo.imageUrl];
    photoLarge.caption = photo.photoTitle;
    
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:@[photoLarge]];
    browser.displayActionButton = NO;
    [self presentViewController:browser animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    NSString *searchString = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    SearchCriteria *criteria = [SearchCriteria sharedObject];
    criteria.text = searchString;
    criteria.type = SearchTypeWithText;
    self.dataArray = nil;
    [self.collectionView reloadData];
    [self loadImages];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    SearchCriteria *criteria = [SearchCriteria sharedObject];
    criteria.type = SearchTypeWithoutText;
    self.dataArray = nil;
    [self.collectionView reloadData];
    [self loadImages];
}


@end
