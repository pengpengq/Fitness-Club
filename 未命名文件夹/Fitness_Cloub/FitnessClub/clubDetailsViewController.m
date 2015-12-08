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
#import "courseDetailViewController.h"
@interface clubDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    BOOL a;
    NSInteger perPage;
    NSInteger totalPage;
    BOOL loadingMore;
    UIActivityIndicatorView *aiv;
    NSString *ns;
    NSString *num;
    
}
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(strong,nonatomic)NSMutableArray *muArr;
@property(strong,nonatomic)clubdateilObject *content;
@property(strong,nonatomic)UIAlertController *alert;
@end

@implementation clubDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    NSDictionary* textTitleOpt = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textTitleOpt];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _objectForShow = [NSMutableArray new];
    [self initializeData];
    [self uiConfiguration];
    //[self secondRequest];
    // Do any additional setup after loading the view.
}
//菊花膜+初始数据
-(void)initializeData{
    loadingMore=NO;
    
    aiv = [Utilities getCoverOnView:self.view];
    [self refreshData];
}
//下拉刷新 +初始数据
-(void)refreshData{
    loadingMore=YES;
    //请求热门的会所列表
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)request{
    if ([[StorageMgr singletonStorageMgr] objectForKey:@"memberId"]==nil) {
        num=_clubID;
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
                [self endRefreshing];
                NSDictionary *rootDictory=[responseObject objectForKey:@"result"];
                NSArray *dataArr=[rootDictory objectForKey:@"experienceInfos"];
                _objectForShow=nil;
                _objectForShow=[NSMutableArray new];
                
                for (NSDictionary *dic in dataArr) {
                    clubdateilObject *object=[[clubdateilObject alloc]initWithDictionary:dic];
                    //            NSLog(@"_objw=%@",object);
                    [_objectForShow addObject:object];
                    //            NSLog(@"_objectForShow=%@",_objectForShow);
                }
                
                _clubAddress.text=[rootDictory objectForKey:@"clubAddressB"];
                _clubTime.text=[rootDictory objectForKey:@"clubTime"];
                _clubName.text=[rootDictory objectForKey:@"clubName"];
                _clubTel.text=[rootDictory objectForKey:@"clubTel"];
                [_clubLogoIV sd_setImageWithURL:[NSURL URLWithString:[rootDictory objectForKey:@"clubLogo"]] placeholderImage:[UIImage imageNamed:@"default"]];
                _clubIntroduce.text=[rootDictory objectForKey:@"clubIntroduce"];
//                [_clubIntroduce sizeToFit];
//                CGRect rect=_headerView.frame;
//                rect.size.height = CGRectGetMaxY(_clubIntroduce.frame) + 10;
//                _headerView.frame = rect;
//                _tableView.tableHeaderView.frame = rect;
//                NSLog(@"tableHeaderViewHeight = %f", _tableView.tableHeaderView.frame.size.height);
//                NSLog(@"contentHeight = %f", _tableView.contentSize.height);
//                
                [_tableView reloadData];
            } else {
                [Utilities popUpAlertViewWithMsg:[responseObject objectForKey:@"resultFlag"] andTitle:nil onView:nil];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"get error = %@", error.description);
            [aiv stopAnimating];
            [self endRefreshing];
            if (error.code==-1009) {
                [Utilities popUpAlertViewWithMsg:@"请检查你的网络再来尝试！"andTitle:nil onView:self];
            }
            
        }];
    
    }
    else{
    num=_clubID;
    NSLog(@"num=%@",num);
    NSString *request = @"/clubController/getClubDetails";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:num,@"clubKeyId",[[StorageMgr singletonStorageMgr] objectForKey:@"memberId"],@"memberId",nil];
    NSLog(@"parameters = %@",parameters);
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        ns=[responseObject objectForKey:@"resultFlag"];
        if ([ns integerValue]==8001){
            //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
            [aiv stopAnimating];
            [self endRefreshing];
            NSDictionary *rootDictory=[responseObject objectForKey:@"result"];
            NSArray *dataArr=[rootDictory objectForKey:@"experienceInfos"];
            _objectForShow=nil;
            _objectForShow=[NSMutableArray new];
            
            for (NSDictionary *dic in dataArr) {
                clubdateilObject *object=[[clubdateilObject alloc]initWithDictionary:dic];
                //            NSLog(@"_objw=%@",object);
                [_objectForShow addObject:object];
                //            NSLog(@"_objectForShow=%@",_objectForShow);
            }
            
            _clubAddress.text=[rootDictory objectForKey:@"clubAddressB"];
            _clubTime.text=[rootDictory objectForKey:@"clubTime"];
            _clubName.text=[rootDictory objectForKey:@"clubName"];
            _clubTel.text=[rootDictory objectForKey:@"clubTel"];
            [_clubLogoIV sd_setImageWithURL:[NSURL URLWithString:[rootDictory objectForKey:@"clubLogo"]] placeholderImage:[UIImage imageNamed:@"default"]];
            _clubIntroduce.text=[rootDictory objectForKey:@"clubIntroduce"];
//            [_clubIntroduce sizeToFit];
//            CGRect rect=_headerView.frame;
//            rect.size.height = CGRectGetMaxY(_clubIntroduce.frame) + 10;
//            _headerView.frame = rect;
//            _tableView.tableHeaderView.frame = rect;
//            NSLog(@"tableHeaderViewHeight = %f", _tableView.tableHeaderView.frame.size.height);
//            NSLog(@"contentHeight = %f", _tableView.contentSize.height);
            
            [_tableView reloadData];
        } else {
            [Utilities popUpAlertViewWithMsg:[responseObject objectForKey:@"resultFlag"] andTitle:nil onView:nil];
        }

    
    } failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
        [aiv stopAnimating];
        [self endRefreshing];
        if (error.code==-1009) {
            [Utilities popUpAlertViewWithMsg:@"请检查你的网络再来尝试！"andTitle:nil onView:self];
        }
        
    }];

    }
    
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
//-(void)secondRequest{
//    NSDate *dateToDay = [NSDate date];
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//   [df setDateFormat:@"yyyy-MM-dd"];
//  NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    [df setLocale:locale];
//    NSString *strDate = [df stringFromDate:dateToDay];
//    NSLog(@"dateToDay is %@",strDate);
//    
//    
//    NSString *request = @"/course/courseListByOneDay";
//    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_clubID, @"clubId",strDate,@"day",nil];
//    
//    
//    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
//        NSLog(@"response = %@", responseObject);
//        
//        
//        
//        
//    } failure:^(NSError *error) {
//        
//        
//        
//        
//        
//    }];
//    
//    
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectForShow.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    clubdateilTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"clubdetailcell"];
   clubdateilObject *object = [_objectForShow objectAtIndex:indexPath.row];
//    NSLog(@"object=%@",object);
    [cell.classImageV sd_setImageWithURL:[NSURL URLWithString:object.eLogo] placeholderImage:[UIImage imageNamed:@"default"]];
    cell.priceLabel.text=[object.price stringValue];
    cell.salecountL.text=[object.saleCount stringValue];
    cell.eName.text=object.eName;
    return cell;
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)uiConfiguration {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSString *title = [NSString stringWithFormat:@"正在刷新..."];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attrsDictionary = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                                      NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                      NSParagraphStyleAttributeName:style,
                                      NSForegroundColorAttributeName:[UIColor brownColor]};
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    refreshControl.attributedTitle = attributedTitle;
    refreshControl.tintColor = [UIColor brownColor];
    refreshControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    refreshControl.tag = 10001;
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}
- (void)endRefreshing{
    loadingMore=NO;
    //在tableView中，根据下标10001获得其子视图
    UIRefreshControl *refreshControl=[self.tableView viewWithTag:10001];
    
    //将上述下拉刷新控件停止刷新
    [refreshControl endRefreshing];//此处的endRefreshing方法为IOS UIKit SDK中UIRefreshControl类的实例方法
}


- (IBAction)collectionAction:(UIBarButtonItem *)sender {
    
    //调用全局变量判断用户是否收藏
    if ([[StorageMgr singletonStorageMgr] objectForKey:@"memberId"]==nil) {
         NSLog(@"wolaile222");
      
        [self showOkayCancelAlert];
      //  [Utilities popUpAlertViewWithMsg:@"您还没登陆不能收藏哦！" andTitle:nil onView:self];
//        UIViewController *view = [Utilities getStoryboardInstance:@"Main" byIdentity:@"logIn"];
//        [self.navigationController pushViewController:view  animated:YES];
       
        return;
    }
   NSLog(@"wolaile");
    NSString *type = @"";
    NSString *request = @"/mySelfController/addFavorites";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:num,@"clubId",[[StorageMgr singletonStorageMgr] objectForKey:@"memberId"],@"memberId",@"0",@"type",nil];
        NSLog(@"parameters = %@",parameters);
        [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
            NSLog(@"get responseObject = %@", responseObject);
            ns=[responseObject objectForKey:@"resultFlag"];
            if ([ns integerValue]==8001){
                
                
            }
            
        }
        failure:^(NSError *error) {
            NSLog(@"get error = %@", error.description);
            [Utilities popUpAlertViewWithMsg:@"请检查网络再来尝试！" andTitle:nil onView:self];
            
        }];

        
    
   
    
    if (a) {
        a=NO;
        [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal  barMetrics:UIBarMetricsDefault];
        
    }else if (a==NO){
        a=YES;
        [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal  barMetrics:UIBarMetricsDefault];
        
    }

    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailTo"]) {
        courseDetailViewController *detail  =   [segue destinationViewController];
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        clubdateilObject *model=[_objectForShow objectAtIndex:indexPath.row];
        detail.eID=model.eID;
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{
    if (buttonIndex == 0) {
        return;
    }
    else if (buttonIndex ==1){
        [self introDidFinish];
    }
    
}
- (void)introDidFinish {
    NSLog(@"Intro callback");
    
    UITabBarController *view =[Utilities getStoryboardInstance:@"Main" byIdentity:@"logIn"];
   [self.navigationController pushViewController:view  animated:YES];
//    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:view];
//    
//    navigation.navigationBarHidden = YES;
//    navigation.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:navigation animated:YES completion:nil];
//    [navigation pushViewController:view  animated:YES];
    
}
- (void)showOkayCancelAlert {
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = NSLocalizedString(@"您还没登陆不能收藏哦！", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"留在本页", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"立即登陆", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
        [self introDidFinish];

    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)dealloc{
    
    _headerView=nil;
    _tableView = nil;
    
}

@end
