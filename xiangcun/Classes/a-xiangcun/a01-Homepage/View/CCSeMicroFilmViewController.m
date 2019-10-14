//
//  CCSeMicroFilmViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/11.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCSeMicroFilmViewController.h"
#import "CCSecondNewThredTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCSecListWebViewController.h"
#import "CCBaseNavViewController.h"
#import "MJRefresh.h"
@interface CCSeMicroFilmViewController ()< UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_secondTableView;
    CCSecondNewThredTableViewCell *_secondCell;
    CCSecListWebViewController *_secListWebViewController;
}
@property (nonatomic,strong)NSMutableArray *datasModel;
@property (nonatomic,assign) NSInteger curPage;
@end

@implementation CCSeMicroFilmViewController

- (NSMutableArray *)datasModel {
    
    if (!_datasModel) {
        
        _datasModel = [NSMutableArray array];
    }
    
    return _datasModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0, 0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#"]];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self setBaseView];
    [self requsetData];
    
    _curPage = 1;
    
    
    _secondTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _secondTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_secondTableView.mj_header beginRefreshing];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}


-(void)setBaseView{
    
    _secondTableView=[[UITableView alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, 0.0, ScreenWidth-10.0/360.0*ScreenWidth, ScreenHeight-69.0/667.0*ScreenHeight)];
    _secondTableView.dataSource=self;
    _secondTableView.delegate=self;
    _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_secondTableView];
        
    
}

-(void)requsetData{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.list.microFilm", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        self.datasModel = [CCSecondThredModel
                           mj_objectArrayWithKeyValuesArray:article];
        // NSLog(@"在线解析＝%@",responseObject);
        
        [_secondTableView reloadData];
        _curPage = 2;
        [_secondTableView.mj_header endRefreshing];
        [_secondTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_secondTableView.mj_header endRefreshing];
        [_secondTableView.mj_footer endRefreshing];
    }];
    
}
//----下拉刷新-----
-(void)loadNewData{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.list.microFilm", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        [self.datasModel removeAllObjects];
        self.datasModel = [CCSecondThredModel
                           mj_objectArrayWithKeyValuesArray:article];
        [_secondTableView reloadData];
        
        
        //_curPage = 2;
        [_secondTableView.mj_header endRefreshing];
        [_secondTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_secondTableView.mj_header endRefreshing];
        [_secondTableView.mj_footer endRefreshing];
    }];
}

//------上拉加载更多-----

- (void)loadMoreData {
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.list.microFilm", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSArray *article = responseObject[@"article"];
        NSArray *dataArr = [CCSecondThredModel
                            mj_objectArrayWithKeyValuesArray:article];
       // [self.datasModel addObjectsFromArray:dataArr];
        
       // [_secondTableView reloadData];
        
        CCSecondThredModel *firstModel = [dataArr firstObject];
        CCSecondThredModel *lastModel = [_datasModel lastObject];
        CCSecondThredModel *lastData = [dataArr lastObject];
        if ([firstModel.ids isEqualToString:lastModel.ids]||[lastModel.ids isEqualToString:lastData.ids]) {
            [_secondTableView.mj_footer endRefreshingWithNoMoreData];
            //[_secondTableView.mj_footer endRefreshing];
            
        } else {
            [_datasModel addObjectsFromArray:dataArr];
            [_secondTableView.mj_footer endRefreshing];
        }
        [_secondTableView.mj_header endRefreshing];
        [_secondTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_secondTableView.mj_header endRefreshing];
        [_secondTableView.mj_footer endRefreshing];
    }];
}

-(void)requestData2{
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
        // NSLog(@"模型内容是＝＝＝＝%@",_secListmodel);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setController:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}
-(void)setController:(id)responseObject{
    
    _secListWebViewController = [[CCSecListWebViewController alloc] init];
    _secListWebViewController.url=_secondmodel.ids;
    _secListWebViewController.title=@"乡村美味";
    _secListWebViewController.model=_secListmodel;
    
//    CCBaseNavViewController *SecondController = [[CCBaseNavViewController alloc]initWithRootViewController:_secListWebViewController];
//    [self presentViewController:SecondController animated:YES completion:nil];
     [self.navigationController pushViewController:_secListWebViewController animated:YES];
    
    
    
    
}

//-----------tableView代理部分-----

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105.0/667.0*ScreenHeight;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasModel.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ids=@"CCSecondNewThredTableViewCell";
    
    _secondCell=[tableView dequeueReusableCellWithIdentifier:ids];
    
    if (_secondCell==nil) {
        _secondCell=[[CCSecondNewThredTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ids];
        
    }
    _secondCell.model=self.datasModel[indexPath.row];
    return _secondCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _secondmodel=self.datasModel[indexPath.row];
    [self requestData2];
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
