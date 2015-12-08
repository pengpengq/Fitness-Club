//
//  courseDetailViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface courseDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ImView;
@property (weak, nonatomic) IBOutlet UILabel *enameLabel;
@property (weak, nonatomic) IBOutlet UILabel *useDate;
@property (weak, nonatomic) IBOutlet UILabel *eFeatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *eClubNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *rulesLabel;
@property (weak, nonatomic) IBOutlet UILabel *orginPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
- (IBAction)linQAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *LinQ;
@property(strong,nonatomic)NSString *eID;

@end
