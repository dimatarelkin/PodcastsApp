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

@interface CollectionViewControllerMaster () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) ServiceManager* manager;

@end





@implementation CollectionViewControllerMaster

static NSString * const reuseIdentifier = @"Cell";
static NSString * const kTedURL = @"https://feeds.feedburner.com/tedtalks_video";
static NSString * const kMP3URL = @"https://rss.simplecast.com/podcasts/4669/rss";

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
    self.manager = [[ServiceManager alloc] init];
    self.manager.delegate = self;
    [self.manager downloadAndParseFileFromURL:urlMP3 withType:MP3SourceType];
    [self.manager downloadAndParseFileFromURL:urlTED withType:TEDSourceType];
    
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

//CELL REUSE
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionVewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ItemObject* item = [self.dataSource objectAtIndex:indexPath.row];
    [cell setDataToLabelsFrom:item];
    
    return cell;
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
    DetailViewController *detail = [[DetailViewController alloc] initWithItem:item];
    [self.splitViewController showDetailViewController:detail sender:nil];
    
    [self.manager  saveItemIntoCoreData:item];
    NSLog(@"item at %ld was tapped", (long)indexPath.row);
}


- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}



#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(CGRectGetWidth(collectionView.frame), 130);
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}



@end
