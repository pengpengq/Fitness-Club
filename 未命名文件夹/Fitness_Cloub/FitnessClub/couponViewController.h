//
//  couponViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface couponViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSInteger loadCount;
    NSInteger perPage;
    NSInteger totalPage;
    BOOL loadingMore;
    
}

@property(strong,nonatomic) NSMutableArray *mutArray;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
