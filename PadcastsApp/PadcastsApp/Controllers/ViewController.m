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
@property (strong, nonatomic) ServiceManager* manager;
@end


static NSString * const kCellIdentifier = @"customCellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.dataSource = [NSMutableArray array];
    
   
    NSURL* urlMP3 = [NSURL URLWithString:@"https://rss.simplecast.com/podcasts/4669/rss"];
    NSURL* urlTED = [NSURL URLWithString:@"https://feeds.feedburner.com/tedtalks_video"];    
    self.manager = [[ServiceManager alloc] init];
    self.manager.delegate = self;
    [self.manager downloadAndParseFileFromURL:urlMP3 withType:0];
    [self.manager downloadAndParseFileFromURL:urlTED withType:1];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    ItemObject *item = [[ItemObject alloc] init];
    item.title           = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row] title];
    item.author          = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row] author];
    item.sourceType      = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row]sourceType];
    item.guiD            = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row] guiD];
    item.descrip         = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row] descrip];
    item.content.webLink = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row] content].webLink;
    item.image.webLink   = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row] image].webLink;
    item.duration        = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row] duration];
    item.publicationDate = [(ItemObject*)[self.dataSource objectAtIndex:indexPath.row] publicationDate];
    
    
    cell.title.text = item.title;
    cell.author.text = item.author;
    cell.type.text = item.sourceType == MP3SourceType ? @"MP3" : @"TED";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(void)downloadingWasFinished:(NSArray*)result {
    [self.dataSource addObjectsFromArray:result];
    [self.tableView reloadData];
    NSLog(@"count = %lu",(unsigned long)self.dataSource.count);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

@end
