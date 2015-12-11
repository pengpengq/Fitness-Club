//
//  reservationViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reservationViewController : UIViewController
- (IBAction)clearmemory:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *memoryLabel;

+ (reservationViewController*)sharedCenter;
@end
