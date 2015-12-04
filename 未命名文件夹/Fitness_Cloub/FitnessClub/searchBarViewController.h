//
//  searchBarViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchBarViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>


@property(nonatomic, strong, readonly) UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;



@end
