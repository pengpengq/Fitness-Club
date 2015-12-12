//
//  logInViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/24.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface logInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)remenberBtn:(UIButton *)sender;
- (IBAction)logInBtn:(UIButton *)sender;
- (IBAction)registerBtn:(UIButton *)sender;
- (IBAction)wjPassBtn:(UIButton *)sender;
- (IBAction)textFiled:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *remerb;




@end
