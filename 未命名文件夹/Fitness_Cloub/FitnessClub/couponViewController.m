//
//  couponViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "couponViewController.h"
#import "couponObject.h"
#import "couponTableViewCell.h"
#import "citiesViewController.h"
@interface couponViewController ()
{
    
    UIActivityIndicatorView *aiv;
}
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
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:loadCount], @"page", [NSNumber numberWithInteger:perPage], @"12",@"experienceId",nil];
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        [aiv stopAnimating];
        if ([[responseObject objectForKey:@"resultFlag"] integerValue]==8001){
            //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
            NSDictionary *rootDictory = [responseObject objectForKey:@"result"];
            NSArray *dataArr = [rootDictory objectForKey:@"models"];
            if (loadCount==1) {
                
                _mutArray=nil;
                _mutArray=[NSMutableArray new];
            }
            NSLog(@"dataArr=%@",dataArr);
            for (NSDictionary *dic in dataArr) {
                couponObject *model=[[couponObject alloc] initWithDictionary:dic];
                NSLog(@"dic=%@",dic);
                [_mutArray addObject:model];
                NSLog(@"_mutArray%@",_mutArray);
            }
            [_tableView reloadData];
        }else{
            [Utilities popUpAlertViewWithMsg:[responseObject objectForKey:@"resultFlag"] andTitle:nil onView:nil];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
        [self.tableView reloadData];
        [aiv stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"请连接好网络后再来尝试!" andTitle:nil onView:self];
    }];
    

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _mutArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    couponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dell"];
    if (!cell) {
        cell = [[couponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dell"];
    }
    couponObject *object = [_mutArray objectAtIndex:indexPath.row];
    NSLog(@"object=%@",object);
    [cell.logoimageView sd_setImageWithURL:[NSURL URLWithString:object.logo] placeholderImage:[UIImage imageNamed:@"default"]];
    cell.clubnameLabel.text=object.name;
    cell.telLabel.text=object.tel;
    cell.endLabel.text=object.enddate;
    cell.useLabel.text=object.usedate;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UI_SCREEN_W / 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
