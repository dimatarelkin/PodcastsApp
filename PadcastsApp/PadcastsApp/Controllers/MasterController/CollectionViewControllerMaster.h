//
//  CollectionViewControllerMaster.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/25/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceManager.h"

@interface CollectionViewControllerMaster : UICollectionViewController <ServiceDownloadDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@end
