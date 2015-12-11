//
//  logInViewController.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/24.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LoginDelegate <NSObject>
@optional
-(void)didLogin;

@end
@interface logInViewController : UIViewController

@property(nonatomic,weak) id<LoginDelegate> loginDelegate;
@property(nonatomic,assign) int viewType;//0:正常登陆 1:返回前页 2://push到指定页面
@property(nonatomic,assign) BOOL isCallBack;
@property(nonatomic,weak) UIViewController *returnTo;


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
