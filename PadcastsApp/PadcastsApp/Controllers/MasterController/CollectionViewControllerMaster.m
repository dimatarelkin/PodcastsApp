//
//  CollectionViewControllerMaster.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/25/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "CollectionViewControllerMaster.h"
#import "CollectionVewCell.h"
#import "DetailViewController.h"
#import "ServiceManager.h"



@interface CollectionViewControllerMaster () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ServiceDownloadDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *images;

@end





@implementation CollectionViewControllerMaster

static NSString * const reuseIdentifier = @"Cell";
static NSString * const kTedURL = @"https://feeds.feedburner.com/tedtalks_video";
static NSString * const kMP3URL = @"https://rss.simplecast.com/podcasts/4669/rss";
static NSInteger  const kImagesInRequest = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Feed";
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
   
    self.collectionView.allowsSelection = YES;
    self.dataSource = [NSMutableArray array];
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionVewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSURL* urlMP3 = [NSURL URLWithString:kMP3URL];
    NSURL* urlTED = [NSURL URLWithString:kTedURL];
    
    [ServiceManager sharedManager].delegate = self;
    [[ServiceManager sharedManager] downloadAndParseFileFromURL:urlTED withType:TEDSourceType];
    [[ServiceManager sharedManager] downloadAndParseFileFromURL:urlMP3 withType:MP3SourceType];
    
    
    

    
#warning download images
//    self.images = [NSMutableArray array];
//    [self getImages];
    
}


#pragma mark <UICollectionViewDataSource>

//SECTION
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//CELL
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


#warning methodDownloader
//-(void)getImages {
//    [[Downloader sharedDownloader]
//     getImagesWithOffset:[self.images count]
//     count:kImagesInRequest
//     onSuccess:^(NSArray *images) {
//         [self.images addObjectsFromArray:images];
//
//         NSMutableArray* newPaths = [NSMutableArray array];
//         for (int i = (int)[self.images count] - (int)[images count]; i < self.images.count; i++) {
//             [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
//         }
//         [self.collectionView insertItemsAtIndexPaths:newPaths];
//     }
//     onFailure:^(NSError *error, NSInteger statusCode) {
//         NSLog(@"error = %@, status code = %ld",[error localizedDescription], (long)statusCode);
//     }];
//}




//CELL REUSE
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionVewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ItemObject* item = [self.dataSource objectAtIndex:indexPath.row];
    [cell setDataToLabelsFrom:item];
    
    if (item.image.localLink != nil) {
        [cell.imageView setImage:[[ServiceManager sharedManager] fetchImageFromSandBoxForItem:item]];
    } else {
        [[ServiceManager sharedManager] downloadImageForItem:item withImageQuality:ImageQualityLow withCompletionBlock:^(NSData *data) {
            [[ServiceManager sharedManager] saveDataWithImage:data IntoSandBoxForItem:item];
            UIImage* img = [UIImage imageWithData:data];
            [cell.imageView setImage:img];
        }];
    }
    

    return cell;
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)downloadingWasFinished:(NSArray*)result {
    [self.dataSource addObjectsFromArray:result];
    [self.collectionView reloadData];
    NSLog(@"count = %lu",(unsigned long)self.dataSource.count);
}



#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    ItemObject *item = [self.dataSource objectAtIndex:indexPath.row];
//    [self.itemDelegate itemWasSelected:item];
    DetailViewController* detail = [[DetailViewController alloc] init];
    [detail itemWasSelected:item];
    [self.splitViewController showDetailViewController:detail sender:nil];
    
    NSLog(@"item at %ld was tapped", (long)indexPath.row);
}


- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}



#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 120);
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}



@end
