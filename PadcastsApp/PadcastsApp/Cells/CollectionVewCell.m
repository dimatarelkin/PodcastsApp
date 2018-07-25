//
//  CollectionVewCell.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/25/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "CollectionVewCell.h"

static NSString * const kMusicPlaceHolder = @"music_placeholder";
static NSString * const kVideoPlaceHolder = @"video_placeholder";

@implementation CollectionVewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}


-(void)setupViews {
    self.title  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.author = [[UILabel alloc] initWithFrame:CGRectZero];
    self.date   = [[UILabel alloc] initWithFrame:CGRectZero];

    //left StackView
    self.duration = [[UILabel alloc] initWithFrame:CGRectZero];
    self.imageView = [[UIImageView alloc]init];
    
    [self createInfoStackView];
    [self createImageAndTypeStackView];
    
    [self.contentView addSubview: self.infoStack];
    [self.contentView addSubview:self. imageView];
    [self setupConstraints];
}

-(void)setDataToLabelsFrom:(ItemObject*)item {
    self.title.text = item.title;
    self.author.text = item.author;
    
    NSDateFormatter * dateFormatter= [[NSDateFormatter alloc] init];
    NSDate* date = [dateFormatter dateFromString:item.publicationDate];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    self.date.text = [dateFormatter stringFromDate:date];

    self.duration.text = item.duration;
    if (item.sourceType == MP3SourceType) {
        [self.imageView setImage:[UIImage imageNamed:kMusicPlaceHolder]];
    } else {
        [self.imageView setImage:[UIImage imageNamed:kVideoPlaceHolder]];
    }
}


-(void)createImageAndTypeStackView {
    self.imageAndTypeStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.imageView,self.duration]];
    
    [self.imageAndTypeStack setAxis:UILayoutConstraintAxisVertical];
    self.imageAndTypeStack.spacing = 5.f;
    [self.imageAndTypeStack setAlignment:UIStackViewAlignmentFill];
    [self.imageAndTypeStack setDistribution:UIStackViewDistributionFill];
    self.imageAndTypeStack.translatesAutoresizingMaskIntoConstraints = NO;
    
}

-(void)createInfoStackView {
    self.infoStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.title, self.author, self.date]];
    [self.infoStack setAxis:UILayoutConstraintAxisVertical];
    self.infoStack.spacing = 5.f;
    [self.infoStack setAlignment:UIStackViewAlignmentFill];
    
}

-(void)setupConstraints {
    [NSLayoutConstraint activateConstraints:
     @[[self.imageAndTypeStack.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10],
       [self.imageAndTypeStack.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
       [self.imageAndTypeStack.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:10],
       [self.imageAndTypeStack.trailingAnchor constraintEqualToAnchor:self.infoStack.leadingAnchor constant:20],
       
       [self.imageAndTypeStack.widthAnchor constraintEqualToAnchor:self.infoStack.widthAnchor multiplier:3],
       [self.infoStack.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:10],
       [self.infoStack.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
       [self.infoStack.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:10]
       ]];
}



@end
