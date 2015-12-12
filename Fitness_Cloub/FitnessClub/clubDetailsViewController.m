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
@interface clubDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
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
@property(strong,nonatomic)NSString *type;
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
    _type=[[NSString alloc]init];
    [self initializeData];
    [self uiConfiguration];
    //[self secondRequest];
    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //创建单例化化通知中心实例
    NSNotificationCenter *notecenter=[NSNotificationCenter defaultCenter];
    //当任何对象（object:nil）发送出requestData时由当前类执行
    [notecenter addObserverForName:@"requestData" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
       
        [self viewDidLoad];
        [_tableView reloadData];
    }];
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
    //用户没登陆的请求
    if ([[StorageMgr singletonStorageMgr] objectForKey:@"memberId"] == nil || [[[StorageMgr singletonStorageMgr] objectForKey:@"memberId"] isKindOfClass:[NSNull class]]) {
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
    
    } else {
        NSLog(@"DuiLe");
        //用户登录后的请求
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
                
                _type=[rootDictory objectForKey:@"isFavicons"];
                NSLog(@"isFavicons=%@",_type);
                if ([_type integerValue] == 1) {
                    _collection.image =[UIImage imageNamed:@"image04"];

                }else if ([_type isEqual:@"0"]){
                    _collection.image =[UIImage imageNamed:@"image03"];

                }
                _clubAddress.text=[rootDictory objectForKey:@"clubAddressB"];
                _clubTime.text=[rootDictory objectForKey:@"clubTime"];
                _clubName.text=[rootDictory objectForKey:@"clubName"];
                _clubTel.text=[rootDictory objectForKey:@"clubTel"];
                [_clubLogoIV sd_setImageWithURL:[NSURL URLWithString:[rootDictory objectForKey:@"clubLogo"]] placeholderImage:[UIImage imageNamed:@"default"]];
                _clubIntroduce.text=[rootDictory objectForKey:@"clubIntroduce"];
                
                
                
                //获取会所体验券详情
                
                NSArray *dataArr=[rootDictory objectForKey:@"experienceInfos"];
                _objectForShow=nil;
                _objectForShow=[NSMutableArray new];
                
                
                for (NSDictionary *dic in dataArr) {
                    clubdateilObject *object=[[clubdateilObject alloc]initWithDictionary:dic];
                    //            NSLog(@"_objw=%@",object);
                    [_objectForShow addObject:object];
                    //            NSLog(@"_objectForShow=%@",_objectForShow);
                }
                
                //            [_clubIntroduce sizeToFit];
                //            CGRect rect=_headerView.frame;
                //            rect.size.height = CGRectGetMaxY(_clubIntroduce.frame) + 10;
                //            _headerView.frame = rect;
                //            _tableView.tableHeaderView.frame = rect;
                //            NSLog(@"tableHeaderViewHeight = %f",          _tableView.tableHeaderView.frame.size.height);
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
    if ([[StorageMgr singletonStorageMgr] objectForKey:@"memberId"] == nil || [[[StorageMgr singletonStorageMgr] objectForKey:@"memberId"] isKindOfClass:[NSNull class]]) {
        
        [self showOkayCancelAlert];
        return;
    }
    
    
    //用户添加收藏
    NSLog(@"wolaile3333");
    NSString *request = @"/mySelfController/addFavorites";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:num,@"clubId",[[StorageMgr singletonStorageMgr] objectForKey:@"memberId"],@"memberId",[_type integerValue] == 1 ? @"0" : @"1",@"type",nil];
    NSLog(@"parameters = %@",parameters);
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        ns=[responseObject objectForKey:@"resultFlag"];
        if ([ns integerValue]==8001){
            if ([_type integerValue] == 1) {
                [Utilities popUpAlertViewWithMsg:@"取消收藏成功！" andTitle:nil onView:self];
                _type = @"0 ";
                _collection.image =[UIImage imageNamed:@"image03"];

            } else {
                [Utilities popUpAlertViewWithMsg:@"收藏成功！" andTitle:nil onView:self];
                _type = @"1";
                _collection.image =[UIImage imageNamed:@"image04"];
            }
        }
    }failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
      //  [aiv stopAnimating];

        [Utilities popUpAlertViewWithMsg:@"收藏失败，请检查网络再来尝试！" andTitle:nil onView:self];
        
    }];

    
    
   
//
//    if (a) {
//        a=NO;
//        [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal  barMetrics:UIBarMetricsDefault];
//        
//    }else if (a==NO){
//        a=YES;
//        [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal  barMetrics:UIBarMetricsDefault];
//        
//    }

    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailTo"]) {
        courseDetailViewController *detail  =   [segue destinationViewController];
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        clubdateilObject *model=[_objectForShow objectAtIndex:indexPath.row];
        detail.eID=model.eID;
        
    }
}


- (void)introDidFinish {
    NSLog(@"Intro callback");
    
    UITabBarController *view =[Utilities getStoryboardInstance:@"Main" byIdentity:@"logIn"];
   [self.navigationController pushViewController:view  animated:YES];
    
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
