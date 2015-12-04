//
//  clubDetailsViewController.m
//  FitnessClub
//
//  Created by 姚国俊 on 15/11/25.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "clubDetailsViewController.h"
#import "clubdateilTableViewCell.h"
#import "clubdateilObject.h"
#import "homeObject.h"
@interface clubDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIActivityIndicatorView *aiv;
    NSString *ns;
}

@end

@implementation clubDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self request];
    [self secondRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)request{
    aiv = [Utilities getCoverOnView:self.view];
    NSString *num=_clubID;
    NSLog(@"num=%@",num);
    NSString *request = @"/clubController/getClubDetails";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:num,@"clubKeyId",nil];
    NSLog(@"parameters = %@",parameters);
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        ns=[responseObject objectForKey:@"resultFlag"];
    if ([ns integerValue]==8001){
            //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
        [aiv stopAnimating];
        NSDictionary *rootDictory=[responseObject objectForKey:@"result"];
        _clubAddress.text=[rootDictory objectForKey:@"clubAddressB"];
        _clubTime.text=[rootDictory objectForKey:@"clubTime"];
        _clubName.text=[rootDictory objectForKey:@"clubName"];
        _clubTel.text=[rootDictory objectForKey:@"clubTel"];
        [_clubLogoIV sd_setImageWithURL:[NSURL URLWithString:[rootDictory objectForKey:@"clubLogo"]] placeholderImage:[UIImage imageNamed:@"default"]];
        _clubIntroduce.text=[rootDictory objectForKey:@"clubIntroduce"];
        [_tableView reloadData];
    }else{
            [Utilities popUpAlertViewWithMsg:[responseObject objectForKey:@"resultFlag"] andTitle:nil onView:nil];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
        [aiv stopAnimating];
        if (error.code==-1009) {
            [Utilities popUpAlertViewWithMsg:@"请检查你的网络再来尝试！"andTitle:nil onView:self];
        }
        
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
//       NSDate *dateToDay = [NSDate date];将获得当前时间
//        NSDateFormatter *df = [[NSDateFormatter alloc] init];
//        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//        [df setLocale:locale];
//        NSString *strDate = [df stringFromDate:dateToDay];
//        NSLog(@"dateToDay is %@",strDate);
//
//
//
//    }
/******当前日期格式化 End******/

//     /******指定日期格式化 Start******/
//    @autoreleasepool {
//
//
//        NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
//        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];//本地化
//        [df setLocale:locale];
//        NSString *myDateString = @"2009-09-15 18:30:00";
//        NSDate *myDate = [df dateFromString:myDateString];
//        NSLog(@"dateToDay is %@",myDate);
//
//
//
//    }
//    /******指定日期格式化 End******/
-(void)secondRequest{
    NSDate *dateToDay = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
   [df setDateFormat:@"yyyy-MM-dd"];
  NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    NSString *strDate = [df stringFromDate:dateToDay];
    NSLog(@"dateToDay is %@",strDate);
    
    
    NSString *request = @"/course/courseListByOneDay";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_clubID, @"clubId",strDate,@"day",nil];
    
    
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"response = %@", responseObject);
        
        
        
        
    } failure:^(NSError *error) {
        
        
        
        
        
    }];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _objectForShow.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    clubdateilTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"clubdateilcell"];
   clubdateilObject *object = [_objectForShow objectAtIndex:indexPath.row];
    NSLog(@"object=%@",object);
    
    return cell;
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)dataAction:(UIButton *)sender {
}
@end
