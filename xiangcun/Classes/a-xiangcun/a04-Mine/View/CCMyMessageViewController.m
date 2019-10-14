//
//  CCMyMessageViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/27.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCMyMessageViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "CCNoticDeWebViewController.h"
#import "CCMyMessageTableViewCell.h"
#import "CCBaseNavViewController.h"
@interface CCMyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    CCNoticDeWebViewController *_noticDetaliWebView;
    CCMyMessageTableViewCell *_secondCell;
}
@property (nonatomic,strong)NSMutableArray *notic;
@property (nonatomic,assign) NSInteger curPage;
@end

@implementation CCMyMessageViewController

- (NSMutableArray *)notic {
    if (!_notic) {
        _notic = [NSMutableArray array];
    }
    return _notic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0,0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self requestMessage];
   
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setBaseView{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 10.0/667.0*ScreenHeight, ScreenWidth, ScreenHeight)];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
     _curPage = 1;
    _tableview.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableview.mj_header beginRefreshing];
    [self.view addSubview:_tableview];
    
    
}
-(void)loadNewData{
    //------刷新公告部分
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"notice.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters1 success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"刷新公告==%@",responseObject);
#pragma mark --刷新前先移除控件，避免重复创建
        
        
        NSArray *noticeList = responseObject[@"noticeList"];
        self.notic=[CCNoticModel
                    mj_objectArrayWithKeyValuesArray:noticeList];
        
        [_tableview.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

- (void)loadMoreData {
    //------刷新公告部分
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
   NSMutableDictionary *parameters1 = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"notice.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters1 success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSArray *article = responseObject[@"article"];
        NSArray *dataArr = [CCNoticModel
                            mj_objectArrayWithKeyValuesArray:article];
        // [self.informations addObjectsFromArray:dataArr];
        
        //[self reloadData];
        
        CCNoticModel *firstModel = [dataArr firstObject];
        CCNoticModel *lastModel = [self.notic lastObject];
        CCNoticModel *lastData = [dataArr lastObject];
        if ([firstModel.ids isEqualToString:lastModel.ids]|| [lastModel.ids isEqualToString:lastData.ids]) {
            [_tableview.mj_footer endRefreshingWithNoMoreData];
            //  [self.mj_footer endRefreshing];
            
        } else {
            [_notic addObjectsFromArray:dataArr];
            [_tableview.mj_footer endRefreshing];
        }
        [_tableview.mj_header endRefreshing];
        [_tableview reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_tableview.mj_header endRefreshing];
        [_tableview.mj_footer endRefreshing];
    }];
}



-(void)requestMessage{
    //--------请求公告数据---------
    NSURL *noticURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=notice.list&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer =[AFJSONResponseSerializer serializer];
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager1 GET:noticURL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray *noticeList = responseObject[@"noticeList"];
        self.notic=[CCNoticModel
                    mj_objectArrayWithKeyValuesArray:noticeList];
        
        [self setBaseView];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
    
}
#pragma mark - tableview代理部分

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _noticModel=self.notic[indexPath.row];
    [self requsetNoticData];
    
}

-(void)requsetNoticData{
    
    NSString *string=[NSString stringWithFormat:@"%@?method=notice.info&appKey=w4q897jgvxkb&v=1.0&format=json&noticeId=%@",KURL,_noticModel.ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:string parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        _noticDetailModel=[CCNoticDetailModel mj_objectWithKeyValues:responseObject];
        
        
        [self setNoticController:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}

-(void)setNoticController:(id)responseObject{
    
    _noticDetaliWebView = [[CCNoticDeWebViewController alloc] init];
     _noticDetaliWebView.url=_noticModel.ids;
    _noticDetaliWebView.model=_noticDetailModel;
    _noticDetaliWebView.title=@"我的消息";
//   CCBaseNavViewController *SecondController = [[CCBaseNavViewController alloc]initWithRootViewController:_noticDetaliWebView];
    [self.navigationController pushViewController:_noticDetaliWebView animated:YES];
    
  
   
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0/667.0*ScreenHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.notic.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ids=@"CCMyMessageTableViewCell";
    
    _secondCell=[tableView dequeueReusableCellWithIdentifier:ids];
    
    if (_secondCell==nil) {
        _secondCell=[[CCMyMessageTableViewCell alloc]init];
        
    }
    _secondCell.model=self.notic[indexPath.row];
    return _secondCell;
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
