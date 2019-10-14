//
//  CCCollectionViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/11/9.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCCollectionViewController.h"
#import "CCHistorySearchCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCSecListWebViewController.h"
#import "CCBaseNavViewController.h"
#import "MJRefresh.h"

@interface CCCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_searchTableView;
    CCHistorySearchCell *_searchCell;
    CCSecListWebViewController *_secListWebViewController;
    NSString *_sessID;
    NSArray *_imageAr;
    NSArray *_titleAr;
    NSArray *_timeAr;
    
}
@property (nonatomic,strong)NSMutableArray *datasModel;
@property (nonatomic,assign) NSInteger curPage;
@end

@implementation CCCollectionViewController
- (NSMutableArray *)datasModel {
    
    if (!_datasModel) {
        
        _datasModel = [NSMutableArray array];
    }
    
    return _datasModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma  mark - 获取用户id
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    _sessID=[dicsLogid objectForKey:@"sessionID"];
    
    [self requsetData];
    self.navigationController.navigationBar.translucent = NO;
    
    //  _imageAr=@[@"11",@"2"];
    //_titleAr=@[@"南方地区葡萄“一年两收”栽培技术",@"广大水域大面积养殖技术成功"];
    //_timeAr=@[@"2016.09.26",@"2016.09.25"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0, 0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    _searchTableView=[[UITableView alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, ScreenWidth-20.0/360.0*ScreenWidth, ScreenHeight-69.0/667.0*ScreenHeight)];
    _searchTableView.delegate=self;
    _searchTableView.dataSource=self;
    [self.view addSubview:_searchTableView];
    _searchTableView.separatorStyle=UITableViewCellSeparatorStyleNone ;
    _curPage = 1;
    
    
    _searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _searchTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_searchTableView.mj_header beginRefreshing];
    
    
}

//----下拉刷新-----
-(void)loadNewData{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.collection.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1",@"sessionId" : [NSString stringWithFormat:@"%@",_sessID]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        self.datasModel = [CCSecondThredModel
                           mj_objectArrayWithKeyValuesArray:article];
        [_searchTableView reloadData];
        
        
        _curPage = 2;
        [_searchTableView.mj_header endRefreshing];
        [_searchTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_searchTableView.mj_header endRefreshing];
        [_searchTableView.mj_footer endRefreshing];
    }];
}

//------上拉加载更多-----

- (void)loadMoreData {
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.collection.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" :[NSString stringWithFormat:@"%zd",_curPage],@"sessionId" : [NSString stringWithFormat:@"%@",_sessID]}];
    
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSArray *article = responseObject[@"article"];
        NSArray *dataArr = [CCSecondThredModel
                            mj_objectArrayWithKeyValuesArray:article];
        
        
        CCSecondThredModel *firstModel = [dataArr firstObject];
        CCSecondThredModel *lastModel = [self.datasModel lastObject];
        CCSecondThredModel *lastData = [dataArr lastObject];
        if ([firstModel.ids isEqualToString:lastModel.ids]||[lastModel.ids isEqualToString:lastData.ids]) {
            [_searchTableView.mj_footer endRefreshingWithNoMoreData];
            
            
        } else {
            [_datasModel addObjectsFromArray:dataArr];
            [_searchTableView.mj_footer endRefreshing];
        }[_searchTableView.mj_header endRefreshing];
        [_searchTableView reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_searchTableView.mj_header endRefreshing];
        [_searchTableView.mj_footer endRefreshing];
    }];
}




-(void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)requsetData{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.collection.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1",@"sessionId" : [NSString stringWithFormat:@"%@",_sessID]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        self.datasModel = [CCSecondThredModel
                           mj_objectArrayWithKeyValuesArray:article];
        //NSLog(@"在线解析会员浏览历史纪录＝%@",responseObject);
        
        [_searchTableView reloadData];
        _curPage = 2;
        [_searchTableView.mj_header endRefreshing];
        [_searchTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_searchTableView.mj_header endRefreshing];
        [_searchTableView.mj_footer endRefreshing];
    }];
    
}



//--------单元格代理部分------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _secondmodel=self.datasModel[indexPath.row];
    [self requestDetailData];
    
}

-(void)requestDetailData{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    NSString *urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_secondmodel.ids,ids];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"详情列表请求成功＝＝JSON: %@", responseObject);
        _secListmodel=[[CCSecListModel  alloc]init];
        _secListmodel=[CCSecListModel mj_objectWithKeyValues:responseObject];
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setController:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
}

-(void)setController:(id)responseObject{
    
    _secListWebViewController = [[CCSecListWebViewController alloc] init];
    _secListWebViewController.url=_secondmodel.ids;
    _secListWebViewController.title=@"我的收藏";
    _secListWebViewController.model=_secListmodel;
    
    
    [self.navigationController pushViewController:_secListWebViewController animated:YES];
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0/667.0*ScreenHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasModel.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_searchTableView]) {
        
        static NSString *id=@"CCHistorySearchCell";
        
        _searchCell=[tableView dequeueReusableCellWithIdentifier:id];
        
        if (_searchCell==nil) {
            
            _searchCell=[[CCHistorySearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
            
        }
        _searchCell.inforModel=self.datasModel[indexPath.row];
        return _searchCell;
    }else
        return nil;
    
    
}

#pragma mark - //删除会员浏览记录
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //----
    return UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
       // _secondmodel=self.datasModel[indexPath.row];
       
        if (self.datasModel.count==0) {
            
        }else{
        _secondmodel=self.datasModel[indexPath.row];
            
            [self deleteRequest];
            
            [self.datasModel removeObjectAtIndex:indexPath.row];
            // Delete the row from the data source.
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"已经删除");
        }
    }
    
    
}

-(void)deleteRequest{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    
    NSDictionary *dic2=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *str1=[dic2 objectForKey:@"sessionID"];
    
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.collection.del", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json",@"id": [NSString stringWithFormat:@"%@",_secondmodel.ids],@"sessionId": [NSString stringWithFormat:@"%@",str1]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
        
        //NSLog(@"退出登录成功返回数据－%@",responseObject);
        
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
}


//修改左滑删除按钮的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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

@end
