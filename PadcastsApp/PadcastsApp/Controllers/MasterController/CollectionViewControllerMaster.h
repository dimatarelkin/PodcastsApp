//
//  CollectionViewControllerMaster.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/25/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemObject.h"


@protocol ItemDelegate
-(void)itemWasSelected:(ItemObject*)item;
@end

@interface CollectionViewControllerMaster : UICollectionViewController
@property (weak, nonatomic) id<ItemDelegate> itemDelegate;
@end


