//
//  logInViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/24.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "logInViewController.h"

@interface logInViewController (){
    BOOL a;
    NSString *Ns;
}
@property (weak, nonatomic) IBOutlet UIView *userNameView;
- (IBAction)closekey:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UIView *passWordView;

@end

@implementation logInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfiguration];
    [self request];
   
    
    if (![[Utilities getUserDefaults:@"userName"] isKindOfClass:[NSNull class]]) {
        _userName.text = [Utilities getUserDefaults:@"userName"];
        
    }
    if ([[Utilities getUserDefaults:@"passWord"] isKindOfClass:[NSNull class]]){
        
        _passWord.text = [Utilities getUserDefaults:@"passWord"];
    }

    
    // Do any additional setup after loading the view.
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [super viewDidAppear:animated];
    if ([[[StorageMgr singletonStorageMgr] objectForKey:@"signUp"] integerValue] == 1) {
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"signUp"];
        
        [self loginWithUsername:[Utilities getUserDefaults:@"userName"] andPassword:[Utilities getUserDefaults:@"password"]];
    }

}
- (void)naviConfiguration {
    NSDictionary* textTitleOpt = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textTitleOpt];

    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(100.f, 150.f, 100.f);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    //self.navigationController.navigationBar.hidden = NO;
    [_remerb setBackgroundImage:[UIImage imageNamed:@"image01"] forState:UIControlStateNormal];
    _remerb.layer.borderColor=[[UIColor blackColor]CGColor];
    _remerb.layer.borderWidth=1.f;
    _userNameView.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _passWordView.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _userNameView.layer.cornerRadius=5.f;
    _passWordView.layer.cornerRadius=5.f;
    _login.layer.cornerRadius=5.f;
     }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)remenberBtn:(UIButton *)sender {
    
    if (a){
        a = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"image01"] forState:UIControlStateNormal];
        
    }
    else{
        a = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"image02"] forState:UIControlStateNormal];
        if ([_passWord.text isEqualToString:@""]&&![[Utilities getUserDefaults:@"passWord"] isKindOfClass:[NSNull class]]){
          
            _passWord.text = [Utilities getUserDefaults:@"passWord"];
        }
    }
}

- (IBAction)logInBtn:(UIButton *)sender {
    
    
    [self request];
    NSString *username = _userName.text;
    NSString *password = _passWord.text;
    username=[username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    password=[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    [self notification];
    
    
   [self loginWithUsername:username andPassword:password];
    

    
}

-(void)notification{
    
    //创建单例化化通知中心实例
    NSNotificationCenter *notecenter=[NSNotificationCenter defaultCenter];
    
    //通知中心的创建
    NSNotification *note=[[NSNotification alloc]initWithName:@"requestData" object:nil userInfo:nil];
    //用通知中心实例发送上述通知
    [notecenter performSelectorOnMainThread:@selector(postNotification:) withObject:note waitUntilDone:YES ];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}




- (IBAction)registerBtn:(UIButton *)sender {
    
  
    UIViewController *view = [Utilities getStoryboardInstance:@"Main" byIdentity:@"register"];
    [self.navigationController pushViewController:view  animated:YES];

    
}

- (IBAction)wjPassBtn:(UIButton *)sender {
    
    UIViewController *view = [Utilities getStoryboardInstance:@"Main" byIdentity:@""];
    [self.navigationController pushViewController:view  animated:YES];
}

- (IBAction)textFiled:(id)sender {
   
     [_passWord becomeFirstResponder];
}

- (void)loginWithUsername:(NSString *)Uname andPassword:(NSString *)pwd {
    if ([Uname isEqualToString:@""] || [pwd isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil onView:self];
        return;
    }
    
    
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    
    NSString *encodedPassword = [NSString encryptWithPublicKeyFromModulusAndExponent:[pwd getMD5_32BitString].UTF8String modulus:[[StorageMgr singletonStorageMgr] objectForKey:@"modulus"] exponent:[[StorageMgr singletonStorageMgr] objectForKey:@"exponent"]];
    NSDictionary *para = @{@"userName":Uname,@"password":encodedPassword,@"deviceType":@7001,@"deviceId":[Utilities uniqueVendor]};
    
    [RequestAPI postURL:@"/login" withParameters:para success:^(id responseObject) {
        //NSLog(@"%@", responseObject);
        [aiv stopAnimating];
        Ns=[responseObject objectForKey:@"resultFlag"];
        
        if (Ns.integerValue==8001){
            [Utilities setUserDefaults:@"userName" content:_userName.text];
            NSLog(@"%@",  responseObject);
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            //存入全局变量StorageMgr singletonStorageMgr中以便以后在收藏中调用
            [[StorageMgr singletonStorageMgr] addKey:@"memberId" andValue:[dict objectForKey:@"memberId"]];
            
            [self tiaozhuan];
        } if (Ns.integerValue==8017||Ns.integerValue==8022||Ns.integerValue==8027||Ns.integerValue==8028){
            [Utilities popUpAlertViewWithMsg:@"亲！您的号码不存在，请先注册吧" andTitle:nil onView:self];
            
        }else if (Ns.integerValue==8029) {
            [Utilities popUpAlertViewWithMsg:@"用户名或密码错误！" andTitle:nil onView:self];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [aiv stopAnimating];
         [Utilities popUpAlertViewWithMsg:[NSString stringWithFormat:@"%ld",(long)error.code] andTitle:nil onView:self];
    }];
}
-(void)tiaozhuan{
    UITabBarController *tab=[Utilities getStoryboardInstance:@"Main" byIdentity:@"home"];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:tab];
    navigation.navigationBarHidden = YES;
    navigation.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navigation animated:YES completion:nil];

}

-(void)request{
    NSString *request = @"/login/getKey";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[Utilities uniqueVendor], @"deviceId", @7001, @"deviceType", nil];
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        NSDictionary* dic = [responseObject objectForKey:@"result"];
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"modulus"];
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"exponent"];
        [[StorageMgr singletonStorageMgr] addKey:@"modulus" andValue:[dic objectForKey:@"modulus"]];
        [[StorageMgr singletonStorageMgr] addKey:@"exponent" andValue:[dic objectForKey:@"exponent"]];
       
    } failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
        if (error.code==-1009) {
          
             [Utilities popUpAlertViewWithMsg:@"请链接好网络后再来尝试！" andTitle:nil onView:self];
            _login.userInteractionEnabled=NO;
            _login.backgroundColor=[UIColor lightGrayColor];
        }else{
            
            [Utilities popUpAlertViewWithMsg:@"网络不通畅，请稍后再试！！" andTitle:nil onView:self];
            
        }
        return ;
        }];
}

- (IBAction)closekey:(UITextField *)sender {
    
    [_passWord resignFirstResponder];
    [_userName resignFirstResponder];
}
-(void)dealloc{
    _passWord = nil;
    _userName = nil;
    _login = nil;
    
}
@end
