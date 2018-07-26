//
//  DetailViewController.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/24/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (instancetype)initWithItem:(ItemObject*)item {
    self = [super init];
    if (self) {
        [self setupViews];
        [self setupItemInfoToViews:item];
    }
    return self;
}


-(void)setupViews {
    
}

-(void)setupItemInfoToViews:(ItemObject*)item {
    
}

- (void)viewDidLoad {
    self.view.backgroundColor = UIColor.blueColor;
    NSLog(@"DetailController has been show");
    [super viewDidLoad];
}

@end
