//
//  registerViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/25.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "registerViewController.h"
#import "MZTimerLabel.h"
@interface registerViewController () <UITextFieldDelegate,MZTimerLabelDelegate>{
    NSString *ns;
    UILabel *timer_show;
}
@property(strong,nonatomic)UIViewController *viewC;
@property (weak, nonatomic) IBOutlet UIButton *tijiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *coderBtn;


@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary* textTitleOpt = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textTitleOpt];
    self.navigationItem.title = @"注册账户";
    _coderBtn.layer.cornerRadius=5;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    //监听键盘打开后的操作执行keyboardWillHide:
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _phoneNum) {
        [_scrollView setContentOffset:CGPointMake(0,-64 + 60) animated:YES];
    } else if (textField == _passWordTF) {
         [_scrollView setContentOffset:CGPointMake(0,-64 + 120) animated:YES];
    } else if (textField == _qpassWord) {
         [_scrollView setContentOffset:CGPointMake(0,-64 + 180) animated:YES];
    } else if (textField == _nums) {
         [_scrollView setContentOffset:CGPointMake(0,-64 + 240) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
     [_scrollView setContentOffset:CGPointMake(0,-64) animated:YES];
}
/*
//键盘打开的操作
- (void)keyboardWillShow:(NSNotification *)notification{
   
    //获得键盘的位置
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算键盘出现后_scrollView都嫩显示
    CGFloat newoffset=(_scrollView.contentSize.height-_scrollView.frame.size.height)+keyboardRect.size.height;
    //将scrollView上移
    [_scrollView setContentOffset:CGPointMake(0,newoffset) animated:YES];
}
//键盘收起的操作
- (void)keyboardWillHide:(NSNotification *)notification{
    
    CGFloat newoffset=(_scrollView.contentSize.height-_scrollView.frame.size.height);
    [_scrollView setContentOffset:CGPointMake(0,-64) animated:YES];
}
*/
- (IBAction)gerCoder:(UIButton *)sender {
    
    if ([_phoneNum.text isEqualToString:@""]) {
        
        [Utilities popUpAlertViewWithMsg:@"请填写手机号码" andTitle:nil onView:self];
        return ;
    }

   

    NSString *request = @"/register/verificationCode";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNum.text, @"userTel", @"1", @"type", nil];
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        if ([[responseObject objectForKey:@"resultFlag"] integerValue]==8002)
        {
            [Utilities popUpAlertViewWithMsg:@"对不起！您输入的不是手机号码，请重新输入！" andTitle:nil onView:self];
        }else{
            [self timeCount];}
    } failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
        [Utilities popUpAlertViewWithMsg:@"验证码获取失败，请检查网络是否畅通！" andTitle:nil onView:self];
     //[self timeCount];
    }];
  
    
}
//倒计时函数
- (void)timeCount{
    [_coderBtn setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 135, 30)];//UILabel设置成和UIButton一样的尺寸和位置
    [_coderBtn addSubview:timer_show];//把timer_show添加到_coderBtn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"重新获取验证码(ss)";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:15.0];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    _coderBtn.userInteractionEnabled = NO;//按钮禁止点击
    _coderBtn.backgroundColor=[UIColor grayColor];
    
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [_coderBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timer_show removeFromSuperview];//移除倒计时模块
    _coderBtn.userInteractionEnabled = YES;//按钮可以点击
    _coderBtn.backgroundColor=[UIColor redColor];
    
}
- (IBAction)tijiaoBtn:(UIButton *)sender {
    NSLog(@"提交了");
    NSString *nickN = _nickName.text;
    NSString *tel = _phoneNum.text;
    NSString *pwd = _passWordTF.text;
    NSString *qPwd = _qpassWord.text;
    NSString *coder = _nums.text;
    
    if ([_nums.text isEqualToString:@""]||[_nickName.text isEqualToString:@""]||[_phoneNum.text isEqualToString:@""]||[_passWordTF.text isEqualToString:@""]||[_qpassWord.text isEqualToString:@""]) {
        
        [Utilities popUpAlertViewWithMsg:@"请先将信息填写完整" andTitle:nil onView:self];
        return ;
    }
    if (![pwd isEqualToString:qPwd]) {
            [Utilities popUpAlertViewWithMsg:@"确认密码必须与密码保持一致" andTitle:nil onView:self];
        return;
    }
    
    NSString *encodedPassword = [NSString encryptWithPublicKeyFromModulusAndExponent:[pwd getMD5_32BitString].UTF8String modulus:[[StorageMgr singletonStorageMgr] objectForKey:@"modulus"] exponent:[[StorageMgr singletonStorageMgr] objectForKey:@"exponent"]];
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[Utilities uniqueVendor], @"deviceId", tel, @"userTel", nickN, @"nickName", encodedPassword, @"userPsw", coder, @"nums", @"0510", @"city", nil];
    [RequestAPI postURL:@"/register" withParameters:parameters success:^(id responseObject) {
        
        NSLog(@"post responseObject = %@", responseObject);
        ns=[responseObject objectForKey:@"resultFlag"];
        [aiv stopAnimating];
        if ([ns integerValue]==8012){
            
            [Utilities popUpAlertViewWithMsg:@"注册成功！" andTitle:nil onView:self];
        }else if ([ns integerValue]==8015){
            
            [Utilities popUpAlertViewWithMsg:@"注册码获取超出次数,请明天再获取" andTitle:nil onView:self];
            
        }else if ([ns integerValue]==8011){
            
            [Utilities popUpAlertViewWithMsg:@"验证码错误" andTitle:nil onView:self];
        }else if ([ns integerValue]==8012){
            
            [Utilities popUpAlertViewWithMsg:@"该用户名已被使用，请尝试其它名称" andTitle:nil onView:self];
            
        }else if ([ns integerValue]==8013){
            [Utilities popUpAlertViewWithMsg:@"注册失败" andTitle:nil onView:self];
        }else if ([ns integerValue]==8016){
            [Utilities popUpAlertViewWithMsg:@"该号码已注册" andTitle:nil onView:self];
            
        }else if ([ns integerValue]==8002){
            [Utilities popUpAlertViewWithMsg:@"对不起！您输入的不是手机号码，请重新输入！" andTitle:nil onView:self];
            
        }
        else{
            [Utilities popUpAlertViewWithMsg:@"亲！请检查网络再来尝试..." andTitle:nil onView:self];
        }

        
        
    }
    failure:^(NSError *error) {
            NSLog(@"post error = %@", error.description);
            [aiv stopAnimating];
       // NSLog(@"%ld",(long)error.code);
        [Utilities popUpAlertViewWithMsg:[NSString stringWithFormat:@"%ld",(long)error.code] andTitle:nil onView:self];
}];

    
}
-(void)dealloc{
    
    timer_show=nil;
}



@end
