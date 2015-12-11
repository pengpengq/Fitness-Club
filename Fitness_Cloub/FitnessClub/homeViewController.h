//
//  homeViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/24.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeTableViewCell.h"
#import "homeObject.h"
@interface homeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSInteger loadCount;
    NSInteger perPage;
    NSInteger totalPage;
    BOOL loadingMore;
    
}



@property(strong,nonatomic)NSString *Str;
@property(strong,nonatomic) NSDictionary *parameters;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)dinwei:(UIBarButtonItem *)sender;
@property(strong,nonatomic) NSMutableArray *objectForShow;
@property(strong,nonatomic) NSMutableArray *mutArray;
@property (weak, nonatomic) IBOutlet UIButton *headerBtnF;
@property (weak, nonatomic) IBOutlet UIButton *headerBtnS;
@property (weak, nonatomic) IBOutlet UIButton *headerBtnT;
@property (weak, nonatomic) IBOutlet UIButton *headerBtnFo;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *headerBtnFi;
@property (weak, nonatomic) IBOutlet UIButton *headerBtnSi;
@property (weak, nonatomic) IBOutlet UIButton *headerBtnSe;
@property (weak, nonatomic) IBOutlet UIButton *headerBtnNi;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cityBarBtn;
@property(strong,nonatomic)UIActivityIndicatorView *tableFooterAI;
@property (strong, nonatomic) NSArray *btnArr;
@property (strong, nonatomic) NSArray *labelArr;
- (IBAction)serachBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dinweiBtn;



@end
