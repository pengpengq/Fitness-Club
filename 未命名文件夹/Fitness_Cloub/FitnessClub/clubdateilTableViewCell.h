//
//  clubdateilTableViewCell.h
//  FitnessClub
//
//  Created by 米老头 on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clubdateilTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *classImageV;
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *unlikeLabel;

@end
