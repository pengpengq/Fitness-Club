//
//  searchBarViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchtableViewCell.h"
@interface searchBarViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;


@end
