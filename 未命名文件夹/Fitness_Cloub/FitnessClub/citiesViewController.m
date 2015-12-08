//
//  citiesViewController.m
//  FitnessClub
//
//  Created by 姚国俊 on 15/11/25.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "citiesViewController.h"
#import "citiesTableViewCell.h"
#import "homeViewController.h"
@interface citiesViewController ()


@end

@implementation citiesViewController
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
       _arrayHotCity = [NSMutableArray arrayWithObjects:@"广州市",@"北京市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
        
        self.array = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self navitation];
    [self dataPrepare];
   
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//导航控制器配置
-(void)navitation{
    self.navigationItem.title=@"城市列表";
    //去除多余的下划线
    _tableView.tableFooterView=[[UIView alloc ]init];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(100, 150, 100);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}
//数据准备
-(void)dataPrepare{
    _cities=[NSMutableDictionary new];
    _array=[NSMutableArray new];
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"citydict" ofType:@"plist"];
    NSFileManager *filemanager=[NSFileManager defaultManager];
    //用NSFileManager 判断上述需要查找的文件是否存在
    if (![filemanager fileExistsAtPath:filePath]) {
        return;
        
    }
    NSMutableDictionary *fileContent= [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    if (!filePath) {
        return;
    }
    //将读到的内容赋予全局变量
    _cities=fileContent;
    //将_cities的键读取到一个数组中
    
    //将上述的数组通过排序赋予_array数组
    _array=(NSMutableArray *)[[_cities allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    //添加热门城市
    NSLog(@"_array%@",_array);
    NSString *Hot = @"热";
  // [_array insertObject:@"热" atIndex:0];
 //  [self.cities setObject:_arrayHotCity forKey:@"热"];
}


#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return _array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据section的信息获得_array数组中对应的Item
    NSString *key=[_array objectAtIndex:section];
    //根据上述的Item作为Cities的键存到数组arr中
    NSArray *arr=[_cities objectForKey:key];
    //根据上述数组的item作为tebleView中的行数
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    citiesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"citiesCell" forIndexPath:indexPath];
    NSString *key=[_array objectAtIndex:indexPath.section];
    NSArray *arr=[_cities objectForKey:key];
    //根据indexPath中的row信息获得包含该行的字典
    NSDictionary *dict=[arr objectAtIndex:indexPath.row];
    //将上述name对应的名称显示在标题标签上
    
    cell.textLabel.text=[dict objectForKey:@"name"];
   // _cityNameLabel.text=cell.textLabel.text;
    //cell.backgroundColor=UIColorFromRGB(100, 180, 50);
    return cell;
}
//返回每一组对应的sectionheader的标题文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_array objectAtIndex:section];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *key=[_array objectAtIndex:indexPath.section];
    NSArray *arr=[_cities objectForKey:key];
    //根据indexPath中的row信息获得包含该行的字典
    NSDictionary *dict=[arr objectAtIndex:indexPath.row];
    _cityNameLabel.text=[dict objectForKey:@"name"];
    
    [self notification:[dict objectForKey:@"name"] andid:[dict objectForKey:@"id"]];
    
}
//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 40.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.view.bounds.size.width, 30)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 250, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    
    NSString *key = [_array objectAtIndex:section];
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else
        titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}

//设置header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}
//设置右侧快捷栏的内容
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _array;
}


//注册通知
-(void)notification:(NSString *)city andid:(NSString *)ID{
    //创建单例化化通知中心实例
    NSNotificationCenter *notecenter=[NSNotificationCenter defaultCenter];
    NSDictionary *dict = @{@"city":city,@"id":ID};
    //通知中心的创建
    NSNotification *note=[[NSNotification alloc]initWithName:@"updateProduct" object:nil userInfo:dict];
    //用通知中心实例发送上述通知
    [notecenter performSelectorOnMainThread:@selector(postNotification:) withObject:note waitUntilDone:YES ];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)backTofirst{
    
  }


@end
