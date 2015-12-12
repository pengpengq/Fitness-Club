//
//  searchBarViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "searchBarViewController.h"
#import "searchObject.h"
@interface searchBarViewController (){
    
   
}
@property(strong,nonatomic) NSMutableArray *ObjectForShow;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSArray *arrResults;//存储搜索结果
@end

@implementation searchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    self.tableView.scrollEnabled = YES;
    _ObjectForShow = [[NSMutableArray alloc]init];
    _arrResults = [[NSArray alloc]init];
    
    [self request];
    
    
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)request{
    _ObjectForShow=[NSMutableArray new];
    NSString *request = @"/clubController/nearSearchClub";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"page", @"10", @"perPage",@"0510",@"city",@"120.31",@"jing",@"31.49",@"wei",@"0",@"type",_searchBar.text, @"keyword",nil];
    [RequestAPI getURL:request withParameters:parameters success:^(id responseObject) {
        NSLog(@"get responseObject = %@", responseObject);
        if ([[responseObject objectForKey:@"resultFlag"] integerValue]==8001){
            //根据接口返回的数据结构拆解数据，用适当的容器（数据类型）盛放底层数据
            NSDictionary *rootDictory=[responseObject objectForKey:@"result"];
            NSArray *dataArr=[rootDictory objectForKey:@"models"];
           
            NSLog(@"dataArr = %@",dataArr);
            
            for (NSDictionary *dic in dataArr) {
            NSString *arr=[[NSString alloc]initWithString:[dic objectForKey:@"clubName"] ];
            //searchObject*object=[[searchObject alloc] initWithDictionary:dic];
            [_ObjectForShow addObject:arr];
            NSLog(@"_objectForShow ＝ %@",_ObjectForShow);
            }
            
           [_tableView reloadData];
        }else{
            
            [Utilities popUpAlertViewWithMsg:[responseObject objectForKey:@"resultFlag"] andTitle:nil onView:nil];
            
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
    
    NSInteger rows = 0;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        rows = [self.arrResults count];
        
    }else{
        
        rows = [_ObjectForShow count];
        
    }    
    
    return rows;
    
   // return _ObjectForShow.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"searchcell";
    searchtableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    searchObject *object=[_ObjectForShow objectAtIndex:indexPath.row];

    
    
    if (cell == nil) {
        
        cell = [[searchtableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    /* Configure the cell. */
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        cell.clubNameL.text = [self.arrResults objectAtIndex:indexPath.row];
        
    }else{
        
        cell.clubNameL.text = [self.ObjectForShow objectAtIndex:indexPath.row];
        
    }   

   //n [cell.imView sd_setImageWithURL:[NSURL URLWithString:object.imageV]placeholderImage:[UIImage imageNamed:@""]];
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
    searchBar.text = @"";
   // [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)setSearchBeginWithText:(NSString *)text{
    if (![_searchBar.text isEqualToString:@""]) {
        [self request];
    }else{
        
        //[Utilities popUpAlertViewWithMsg:@"请输入搜索内容！" andTitle:nil onView:self];
    }
    
  
}
- (void)filterContentForSearchText:(NSString*)searchText                               scope:(NSString*)scope {
    
    NSPredicate *resultPredicate = [NSPredicate                                      predicateWithFormat:@"SELF contains[cd] %@",                                     searchText];
    
    self.arrResults = [self.ObjectForShow filteredArrayUsingPredicate:resultPredicate];
    
}



#pragma mark - UISearchDisplayController delegate methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString                                 scope:[[self.searchDisplayController.searchBar scopeButtonTitles]                                       objectAtIndex:[self.searchDisplayController.searchBar                                                      selectedScopeButtonIndex]]];
    
    return YES;
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]                                 scope:[[self.searchDisplayController.searchBar scopeButtonTitles]                                       objectAtIndex:searchOption]];
    
    return YES;
    
}
@end
