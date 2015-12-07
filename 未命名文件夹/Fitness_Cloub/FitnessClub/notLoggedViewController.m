//
//  notLoggedViewController.m
//  FitnessClub
//
//  Created by QAQ on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "notLoggedViewController.h"

@interface notLoggedViewController ()

@end

@implementation notLoggedViewController

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

- (IBAction)entryAction:(UIButton *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Main" byIdentity:@"entry"];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:view];
    navigation.navigationBarHidden = YES;
    navigation.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navigation animated:YES completion:nil];
}
@end
