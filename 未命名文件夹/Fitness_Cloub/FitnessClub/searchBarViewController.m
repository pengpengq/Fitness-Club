//
//  searchBarViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "searchBarViewController.h"

@interface searchBarViewController ()
@property(strong,nonatomic) NSMutableArray *ObjectForShow;
@end

@implementation searchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_tableView=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [_searchBar becomeFirstResponder];
    
   // [self request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)request{
    _ObjectForShow=[NSMutableArray new];
    NSString *request = @"/clubController/nearSearchClub";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"page", @"10", @"perPage",@"0510",@"city",@"120.31",@"jing",@"31.49",@"wei",@"0",@"type",nil];
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        if ([[responseObject objectForKey:@"resultFlag"] integerValue]==8001){
            //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
            NSDictionary *rootDictory=[responseObject objectForKey:@"result"];
            NSArray *dataArr=[rootDictory objectForKey:@"models"];
            NSLog(@"dataArr = %@",dataArr);
            
            for (NSDictionary *dic in dataArr) {
                clubObject*object=[[clubObject alloc] initWithDictionary:dic];
                [_ObjectForShow addObject:object];
                NSLog(@"_objectForShow ＝ %@",_ObjectForShow);
            }
            [_tableView reloadData];
        }else{
            
            
            
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
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return  cell;
    
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self setSearchBeginWithText:searchText];
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"取消";
   // [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)setSearchBeginWithText:(NSString *)text{
    if (![_searchBar.text isEqualToString:@""]) {
        [self request];
    }
    
    
    
    
    
    
    
}

@end
