//
//  CollectionVewCell.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/25/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemObject.h"

@interface CollectionVewCell : UICollectionViewCell

//right StackView
@property (strong, nonatomic) UIStackView *infoStack;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *author;
@property (strong, nonatomic) UILabel *date;

//left StackView
@property (strong, nonatomic) UIStackView *imageAndTypeStack;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *duration;


-(void)setDataToLabelsFrom:(ItemObject*)item;

@end
