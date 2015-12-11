//
//  registerViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/25.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *qpassWord;

@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *nums;
- (IBAction)gerCoder:(UIButton *)sender;
- (IBAction)tijiaoBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;




@end
