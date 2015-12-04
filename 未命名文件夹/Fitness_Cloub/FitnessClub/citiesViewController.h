//
//  citiesViewController.h
//  FitnessClub
//
//  Created by 姚国俊 on 15/11/25.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface citiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *array;
@property(strong,nonatomic)NSMutableDictionary *cities;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sysCityLabel;

@property (nonatomic, strong) NSMutableArray *arrayHotCity;

@end
