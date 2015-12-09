//
//  homeViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/24.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "homeViewController.h"

#import "citiesViewController.h"
@interface homeViewController ()
{
    
    UIActivityIndicatorView *aiv;
    NSString *ID;
}
@property (weak, nonatomic) IBOutlet UIView *headerView;

-(void)endRefreshing;
@end

@implementation homeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    ID = @"0510";
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self naviConfiguration];
   
     [self uiConfiguration];
     
    _btnArr = @[_headerBtnF, _headerBtnT, _headerBtnS, _headerBtnFo, _headerBtnFi, _headerBtnSi, _headerBtnSe, _headerBtnNi];
    _labelArr=@[_label1,_label2,_label3,_label4,_label5,_label6,_label7,_label8];
    //请求健身类别
   [self request];
    
    //请求热门会所列表
    [self performSelector:@selector(initializeData) withObject:nil afterDelay:0];
    
        // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //创建单例化化通知中心实例
    NSNotificationCenter *notecenter=[NSNotificationCenter defaultCenter];
    //当任何对象（object:nil）发送出updateProuct时由当前类执行(updateProductName:)的方法
    [notecenter addObserverForName:@"updateProduct" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSDictionary *dict = note.userInfo;
        NSString *city = dict[@"city"];
        
        ID=dict[@"id"];
       NSLog(@"ID=%@",ID);
       _cityBarBtn.title=city;
       [self secondrequestData];
        [_tableView reloadData];
    }];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _headerBtnF.layer.cornerRadius=_headerBtnF.frame.size.width/2;
    _headerBtnT.layer.cornerRadius=_headerBtnF.frame.size.width/2;
    _headerBtnS.layer.cornerRadius=_headerBtnF.frame.size.width/2;
    _headerBtnFo.layer.cornerRadius=_headerBtnF.frame.size.width/2;
    _headerBtnFi.layer.cornerRadius=_headerBtnF.frame.size.width/2;
    _headerBtnSi.layer.cornerRadius=_headerBtnF.frame.size.width/2;
    _headerBtnSe.layer.cornerRadius=_headerBtnF.frame.size.width/2;
    _headerBtnNi.layer.cornerRadius=_headerBtnF.frame.size.width/2;
   
    
    
}



- (void)naviConfiguration {
    CGRect rect = _headerView.frame;
    rect.size.height = (UI_SCREEN_W - 130.f) / 2 + 85.f;
    _headerView.frame = rect;
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(100, 150, 100);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary* textTitleOpt = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textTitleOpt];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    //self.navigationController.navigationBar.hidden = NO;
    //[self.navigationController.navigationBar setTranslucent:YES];
}
//菊花膜+初始数据
-(void)initializeData{
    loadingMore=NO;
    perPage=10;
    aiv = [Utilities getCoverOnView:self.view];
    [self refreshData];
}
//下拉刷新 +初始数据
-(void)refreshData{
    loadingMore=YES;
    loadCount=1;
    //请求热门的会所列表
    [self secondrequestData];
}

-(void)request{
        NSString *request = @"/homepage/category";
  
        NSDictionary *para = @{@"page":@"1",@"perPage":@"10"};
        [RequestAPI getURL:request withParameters:para success:^(id responseObject) {
            NSLog(@"get responseObject = %@", responseObject);
            if ([[responseObject objectForKey:@"resultFlag"] integerValue]==8001){
                //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
                NSDictionary *rootDictory=[responseObject objectForKey:@"result"];
                NSArray *dataArr=[rootDictory objectForKey:@"models"];
                
                //NSLog(@"dic= %@",dataArr);
                //NSDictionary *pageDict=[rootDictory objectForKey:@"pagingInfo"];
                for (int i = 0; i < dataArr.count; i ++) {
                    NSDictionary *dic = [dataArr objectAtIndex:i];
                    homeclubkindObject *model=[[homeclubkindObject alloc] initWithDictionary:dic];
                    [_objectForShow addObject:model];
                    UIButton *btn = [_btnArr objectAtIndex:i];
                    UILabel *labelC=[_labelArr objectAtIndex:i];
                    
                    [labelC setText:model.name];
                    [labelC setTextColor:UIColorFromRGB(100, 100, 100)];
                    [btn setBackgroundImage:[Utilities imageUrl:model.backimgurl] forState:UIControlStateNormal];
                    //             [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.backimgurl ] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
            //}
}
//                NSInteger totalPage=[[pageDict objectForKey:@"totalPage"] integerValue];
//                NSLog(@"%ld",totalPage);
            }else{
                
                [Utilities popUpAlertViewWithMsg:[responseObject objectForKey:@"resultFlag"] andTitle:nil onView:nil];
            }
        } failure:^(NSError *error) {
            NSLog(@"get error = %@", error.description);
        }];
}
-(void)secondrequestData{
    NSString *request = @"/homepage/choice";
    
    //NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:loadCount], @"page", [NSNumber numberWithInteger:perPage], @"perPage", nil];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:loadCount], @"page", [NSNumber numberWithInteger:perPage], @"perPage",ID,@"city",@"120.31",@"jing",@"31.49",@"wei",nil];
    NSLog(@"parameters = %@", parameters);
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        [aiv stopAnimating];
      [self endRefreshing];
       //收起上啦刷新的Footer
        [self loadDataEnd];
        NSString *ns=[responseObject objectForKey:@"resultFlag"];
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
                homeObject *model = [[homeObject alloc] initWithDictionary:dic];
                NSLog(@"dic=%@",dic);
                [_mutArray addObject:model];
                NSLog(@"_mutArray%@",_mutArray);
            }
            [_tableView reloadData];
          
        }else if ([ns integerValue] == 8020){
            
         //   [Utilities popUpAlertViewWithMsg:@"该城市暂未开通服务！" andTitle:nil onView:self];
            
        }
        else{
            [Utilities popUpAlertViewWithMsg:[responseObject objectForKey:@"resultFlag"] andTitle:nil onView:nil];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"get error = %@", error.description);
        
      
       [self.tableView reloadData];
        [self endRefreshing];
        [self loadDataEnd];
        [aiv stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"请连接好网络后再来尝试!" andTitle:nil onView:self];
    }];
    
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _mutArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     homeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[homeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    homeObject *object = [_mutArray objectAtIndex:indexPath.row];
    NSLog(@"object=%@",object);
    [cell.cellImageV sd_setImageWithURL:[NSURL URLWithString:object.ImgUrl] placeholderImage:[UIImage imageNamed:@"default"]];
    
    cell.nameLabel.text=object.name;
    cell.detailsLabel.text=object.detail;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UI_SCREEN_W / 3;

    
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
//当scrollView的拖拽行为完成时调用以下方法
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentSize.height > scrollView.frame.size.height) {
        if (!loadingMore && scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
            [self loadDataBegin];
        }
    } else {
        if (!loadingMore && scrollView.contentOffset.y > 0) {
            [self loadDataBegin];
        }
    }
    
    
}

//做上拉翻页的页面准备工作
- (void)loadDataBegin {
    loadingMore = YES;
    [self createTableFooter];
    _tableFooterAI = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((UI_SCREEN_W - 86.0f) / 2 - 30.0f, 10.0f, 20.0f, 20.0f)];
    [_tableFooterAI setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.tableView.tableFooterView addSubview:_tableFooterAI];
    [_tableFooterAI startAnimating];
    [self loadDataing];
    
}
//开始加载新页数据
- (void)loadDataing {
    NSLog(@"%ld", (long)totalPage);
    totalPage=20;
    if (totalPage > loadCount) {
        loadCount ++;
        [self secondrequestData];
    } else {
        [self performSelector:@selector(beforeLoadEnd) withObject:nil afterDelay:0.25];
    }
}
//在没有更多页的情况下告诉用户 没有更多数据
- (void)beforeLoadEnd {
    UILabel *label = (UILabel *)[self.tableView.tableFooterView viewWithTag:9001];
    [label setText:@"当前已无更多数据"];
    [_tableFooterAI stopAnimating];
    _tableFooterAI = nil;
    [self performSelector:@selector(loadDataEnd) withObject:nil afterDelay:0.25];
}
//翻页结束后收起下面的提示框
- (void)loadDataEnd {
    self.tableView.tableFooterView = [[UIView alloc] init];
    loadingMore = NO;
}
//创建tableVlew的视图
- (void)createTableFooter {
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 40.0f)];
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_W - 86.0f) / 2, 0.0f, 116.0f, 40.0f)];
    loadMoreText.tag = 9001;
    [loadMoreText setFont:[UIFont systemFontOfSize:B_Font]];
    [loadMoreText setText:@"上拉显示更多数据"];
    [tableFooterView addSubview:loadMoreText];
    loadMoreText.textColor = [UIColor grayColor];
    self.tableView.tableFooterView = tableFooterView;
}


- (IBAction)dinwei:(UIBarButtonItem *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Main" byIdentity:@"cities"];
    [self.navigationController pushViewController:view  animated:YES];
}



- (IBAction)serachBtn:(UIButton *)sender {
    UIViewController *view = [Utilities getStoryboardInstance:@"Main" byIdentity:@"search"];
    [self.navigationController pushViewController:view  animated:YES];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier] isEqualToString:@"homeTo"]) {
           clubDetailsViewController *detail=[segue destinationViewController];
         NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
         NSLog(@"indexPath=%ld",(long)indexPath.row);
        homeObject *model=[_mutArray objectAtIndex:indexPath.row];
         NSLog(@"model=%@",model);
         detail.clubID=model.ID;
         NSLog(@"model.ID=%@",model.ID);
     }
}

-(void)dealloc{
    
    
    
}
@end
