//
//  personViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/24.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "personViewController.h"

@interface personViewController ()

@end

@implementation personViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)collectAction:(UIButton *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Person" byIdentity:@"myCollection"];
    [self.navigationController pushViewController:view  animated:YES];
}

- (IBAction)coupon:(UIButton *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Person" byIdentity:@"coupon"];
    [self.navigationController pushViewController:view  animated:YES];
}

- (IBAction)mydetailAction:(UIButton *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Person" byIdentity:@"mydetail"];
    [self.navigationController pushViewController:view  animated:YES];
}

- (IBAction)reservation:(UIButton *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Person" byIdentity:@"reservation"];
    [self.navigationController pushViewController:view  animated:YES];
}

- (IBAction)service:(UIButton *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Person" byIdentity:@"service"];
    [self.navigationController pushViewController:view  animated:YES];
}

- (IBAction)feedbackAction:(UIButton *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Person" byIdentity:@"feedBack"];
    [self.navigationController pushViewController:view  animated:YES];
}
@end
