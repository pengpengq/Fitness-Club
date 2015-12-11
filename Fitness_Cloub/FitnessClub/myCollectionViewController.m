//
//  myCollectionViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "myCollectionViewController.h"
#import "myCollectionObject.h"
@interface myCollectionViewController ()

@end

@implementation myCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)request{
    NSString *request = @"/mySelfController/memberScore";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"18607075365",@"memberId",@"120.12",@"jing",@"31.49",@"wei",@"1",@"favouriteId",nil];
    NSLog(@"parameters = %@",parameters);
    [RequestAPI getURL:request withParameters:parameters success:^(id myCollectionObject) {
        NSLog(@"get myCollectionObject = %@", myCollectionObject);
        if ([[myCollectionObject objectForKey:@"resultFlag"] integerValue]==8001){
            //            //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
            NSDictionary *rootDictory=[myCollectionObject objectForKey:@"result"];
         
        }
    } failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
