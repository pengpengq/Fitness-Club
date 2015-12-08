//
//  courseDetailViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "courseDetailViewController.h"
#import "courseObject.h"
@interface courseDetailViewController ()
@property(strong,nonatomic)NSMutableArray *objectForShow;

@end

@implementation courseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
    // Do any additional setup after loading the view.
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
-(void)request{
   
    NSString *request = @"/clubController/experienceDetail";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_eID, @"experienceId",nil];
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        if([[responseObject objectForKey:@"resultFlag"] integerValue]==8001){
            
            NSDictionary *rootDictory=[responseObject objectForKey:@"result"];
            _enameLabel.text=[rootDictory objectForKey:@"eName"];
            [_ImView sd_setImageWithURL:[NSURL URLWithString:[rootDictory objectForKey:@"eLogo"]] placeholderImage:[UIImage imageNamed:@"default"]];
            _eAddressLabel.text =   [rootDictory objectForKey:@"eAddress"];
            _eClubNameLabel.text    =   [rootDictory objectForKey:@"eClubName"];
            _telLabel.text  =   [rootDictory objectForKey:@"clubTel"];
            _rulesLabel.text = [rootDictory objectForKey:@"rules"];
            _eFeatureLabel.text = [rootDictory objectForKey:@"eFeature"];
            _useDate.text=[rootDictory objectForKey:@"useDate"];
            _orginPriceLabel.text=[[rootDictory objectForKey:@"orginPrice"]stringValue];
            _currentPriceLabel.text=[[rootDictory objectForKey:@"currentPrice"]stringValue];

            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
        
        if (error.code==-1009) {
            [Utilities popUpAlertViewWithMsg:@"请检查你的网络再来尝试！"andTitle:nil onView:self];
        }
        
        
    }];
    
}
- (IBAction)linQAction:(UIButton *)sender {
    
    
    
}
@end
