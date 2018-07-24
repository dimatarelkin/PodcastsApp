//
//  ViewController.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"

 

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ParserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

