//
//  clubDetailsViewController.h
//  FitnessClub
//
//  Created by 姚国俊 on 15/11/25.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clubDetailsViewController : UIViewController{
    NSInteger loadCount;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentheight;
@property(strong,nonatomic)NSMutableArray *objectForShow;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *clubLogoIV;
@property (weak, nonatomic) IBOutlet UILabel *clubName;
@property (weak, nonatomic) IBOutlet UILabel *clubTime;
@property (weak, nonatomic) IBOutlet UILabel *clubTel;
@property (weak, nonatomic) IBOutlet UILabel *clubAddress;
@property (weak, nonatomic) IBOutlet UILabel *clubIntroduce;
@property(strong,nonatomic) NSString *clubID;





@end
