//
//  couponTableViewCell.h
//  FitnessClub
//
//  Created by QAQ on 15/12/4.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface couponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *clubnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@property (weak, nonatomic) IBOutlet UIImageView *logoimageView;

@property (weak, nonatomic) IBOutlet UILabel *useLabel;

@property (weak, nonatomic) IBOutlet UILabel *endLabel;


@end
