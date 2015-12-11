//
//  nearbyViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "nearbyViewController.h"

@interface nearbyViewController ()
@property(strong,nonatomic)NSMutableArray *objectForShow;
@end

@implementation nearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)request{
    NSString *request = @"/clubController/getNearInfos";
    
    NSDictionary *para = @{@"city":@"0510"};
    [RequestAPI getURL:request withParameters:para success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        if ([[responseObject objectForKey:@"resultFlag"] integerValue]==8001){
            //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
            NSDictionary *rootDictory=[responseObject objectForKey:@"result"];
            NSArray *dataArr=[rootDictory objectForKey:@"addressList"];
            NSDictionary *secondrootDt=[rootDictory objectForKey:@"features"];
            NSLog(@"secondrootDt=%@",secondrootDt);
             NSArray *dataArr2=[secondrootDt objectForKey:@"featureForm "];
            NSLog(@"dataArr2=%@",dataArr2);
            NSLog(@"dataArr=%@",dataArr);
        }
    
    }failure:^(NSError *error) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"nearby"];
    return cell;
}


@end
