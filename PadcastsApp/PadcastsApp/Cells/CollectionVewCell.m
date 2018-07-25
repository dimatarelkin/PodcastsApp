//
//  CollectionVewCell.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/25/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "CollectionVewCell.h"

static NSString * const kMusicPlaceHolder = @"music_placeholder2";
static NSString * const kVideoPlaceHolder = @"video_placeholder3";


@interface CollectionVewCell()
@property (assign, nonatomic) CGFloat multiplier;
@end


@implementation CollectionVewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
        [self setupViews];
    }
    return self;
}

-(void)setupCell{
    self.backgroundColor = UIColor.whiteColor;
    self.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.4;
}

-(void)setupViews {
    self.title  = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.title setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.title.numberOfLines = 3;
    [self.title setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisVertical];
    
    self.author = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.author setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]];
    
    self.date   = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.date setFont: [UIFont systemFontOfSize:12]];

    //left StackView
    self.duration = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.duration setFont:[UIFont systemFontOfSize:12]];
    [self.duration setTextAlignment:NSTextAlignmentCenter];
//    self.duration.textColor = UIColor.whiteColor;
//    self.duration.backgroundColor = UIColor.blackColor;
    
    //imageView
    self.imageView = [[UIImageView alloc]init];
    [self.imageView  setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setClipsToBounds:YES];
    
    
    //setting socntrainst and stack
    [self createInfoStackView];
    [self createImageAndTypeStackView];
    
    [self addSubview: self.infoStack];
    [self addSubview:self.imageAndTypeStack];
    [self setupConstraints];
}

-(void)setDataToLabelsFrom:(ItemObject*)item {
    self.title.text = item.title;
    
    
    self.author.text = item.author;
    [self.author setTextAlignment:NSTextAlignmentLeft];
    
    NSString *dateStr = item.publicationDate;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E, dd MMM yyyy HH:mm:ss Z"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    [dateFormat setDateFormat:@"E dd MMM yyyy HH:mm"];
    dateStr = [dateFormat stringFromDate:date];
    self.date.text = dateStr;
    self.date.textColor = [UIColor blackColor];
    [self.date setTextAlignment:NSTextAlignmentRight];

    
    self.duration.text = item.duration;
    if (item.sourceType == MP3SourceType) {
        [self.imageView setImage:[UIImage imageNamed:kMusicPlaceHolder]];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    } else {
        [self.imageView setImage:[UIImage imageNamed:kVideoPlaceHolder]];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
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
    self.infoStack.spacing = 0;
    [self.infoStack setAlignment:UIStackViewAlignmentFill];
    [self.infoStack setDistribution:UIStackViewDistributionFill];
    self.infoStack.translatesAutoresizingMaskIntoConstraints = NO;
}

-(void)setupConstraints {
    [NSLayoutConstraint activateConstraints:
     @[[self.imageAndTypeStack.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
       [self.imageAndTypeStack.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
       [self.imageAndTypeStack.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10],
       [self.imageAndTypeStack.trailingAnchor constraintEqualToAnchor:self.infoStack.leadingAnchor constant: -20],
       
       [self.imageAndTypeStack.widthAnchor constraintEqualToAnchor:self.infoStack.widthAnchor multiplier:0.5],
       [self.infoStack.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
       [self.infoStack.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
       [self.infoStack.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10]
       ]];
}



@end
