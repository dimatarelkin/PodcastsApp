//
//  CollectionViewControllerMaster.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/25/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "CollectionViewControllerMaster.h"
#import "CollectionVewCell.h"


@interface CollectionViewControllerMaster () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) ServiceManager* manager;

@end





@implementation CollectionViewControllerMaster

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Feed";
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
   
    self.collectionView.allowsSelection = YES;
    self.dataSource = [NSMutableArray array];
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionVewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSURL* urlMP3 = [NSURL URLWithString:@"https://rss.simplecast.com/podcasts/4669/rss"];
    NSURL* urlTED = [NSURL URLWithString:@"https://feeds.feedburner.com/tedtalks_video"];
    self.manager = [[ServiceManager alloc] init];
    self.manager.delegate = self;
    [self.manager downloadAndParseFileFromURL:urlMP3 withType:0];
    [self.manager downloadAndParseFileFromURL:urlTED withType:1];
    
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
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:<#(UICollectionViewScrollPosition)#>];
    NSLog(@"itssem at %d was tapped", indexPath.row);
}
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}



#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(CGRectGetWidth(collectionView.frame) - 15, CGRectGetHeight(collectionView.frame)/5 - 10);
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 130);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(30, 0, 0, 0);
}

@end
