//
//  couponViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "couponViewController.h"
#import "couponObject.h"
@interface couponViewController ()

@end

@implementation couponViewController

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
    NSString *request = @"/clubController/experienceDetail";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"12",@"experienceId",nil];
    [RequestAPI getURL:request withParameters:parameters success:^(id couponObject) {
        NSLog(@"get personDetailsObject = %@", couponObject);
        if ([[couponObject objectForKey:@"resultFlag"] integerValue]==8001){
            //            //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
            NSDictionary *rootDictory=[couponObject objectForKey:@"result"];
            
            //            NSArray *dataArr=[rootDictory objectForKey:@"models"];
            //            NSDictionary *pageDict=[rootDictory objectForKey:@"pagingInfo"];
            //_headerBtnF.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithData:data]];
                        for (int i = 0; i < rootDictory.count; i ++) {
            //                NSDictionary *dic = [dataArr objectAtIndex:i];
            //                homeObject *model=[[homeObject alloc] initWithDictionary:dic];
            //                [_objectForShow addObject:model];
            //                UIButton *btn = [_btnArr objectAtIndex:i];
            //                [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.backimgurl ] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
                        }
            //
        }else{
            //[Utilities popUpAlertViewWithMsg:[responseObject objectForKey:@"resultFlag"] andTitle:nil];
            [Utilities popUpAlertViewWithMsg:[couponObject objectForKey:@"resultFlag"] andTitle:nil onView:nil];
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
