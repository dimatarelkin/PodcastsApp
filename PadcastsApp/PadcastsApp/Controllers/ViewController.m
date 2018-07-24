//
//  ViewController.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "ViewController.h"
#import "Parser.h"
#import "CustomCellTableViewCell.h"

@interface ViewController ()
@property (strong, nonatomic)NSMutableArray* dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataSource = [NSMutableArray array];
    
    NSURL* urlMP3 = [NSURL URLWithString:@"https://rss.simplecast.com/podcasts/4669/rss"];
    NSURL* urlTED = [NSURL URLWithString:@"https://feeds.feedburner.com/tedtalks_video"];
    Parser* mp3 = [[Parser alloc] initWithURL:urlMP3 resourceType:0];
    mp3.delegate = self;
    Parser* ted = [[Parser alloc] initWithURL:urlTED resourceType:1];
    ted.delegate = self;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomCellTableViewCell *cell = [[CustomCellTableViewCell alloc] init];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(void)downloadingWasFinishedWithResult:(NSArray*)result {
    [self.dataSource addObjectsFromArray:result];
    [self.tableView reloadData];
    NSLog(@"count = %lu",(unsigned long)self.dataSource.count);
}
//
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder { 
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection { 
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize { 
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator { 
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate { 
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context { 
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded { 
//    <#code#>
//}

@end
