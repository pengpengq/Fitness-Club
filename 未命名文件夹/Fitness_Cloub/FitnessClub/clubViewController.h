//
//  clubViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/24.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clubViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSInteger loadCount;
    NSInteger perPage;
    NSInteger totalPage;
    BOOL loadingMore;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(strong,nonatomic)NSMutableArray *objectForShow;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(strong,nonatomic)UIActivityIndicatorView *tableFooterAI;
- (IBAction)dinwei:(UIBarButtonItem *)sender;

@end
