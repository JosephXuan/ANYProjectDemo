//
//  CCNewThredSecondViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/27.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCCommendSearch .h"
#import "CCSecondNewThredTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCSecListWebViewController.h"
#import "CCBaseNavViewController.h"
#import "MJRefresh.h"
@interface CCCommendSearch  ()< UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_secondTableView;
    CCSecondNewThredTableViewCell *_secondCell;
    CCSecListWebViewController *_secListWebViewController;
    NSString *_searchWord;
    UILabel *_RtimeLable;
    UILabel *_footLable;

}
@property (nonatomic,strong)NSMutableArray *datasModel;
@property (nonatomic,assign) NSInteger curPage;
@end

@implementation CCCommendSearch 
-(void)setAreaID:(NSString *)areaID{
    if (_areaID!=areaID) {
        _areaID=areaID;
       
        
    }
}

- (NSMutableArray *)datasModel {
    
    if (!_datasModel) {
        
        _datasModel = [NSMutableArray array];
    }
    
    return _datasModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAreaID:_areaID];
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
    _secondTableView.separatorStyle=UITableViewCellSeparatorStyleNone ;
    [self.view addSubview:_secondTableView];
//------自定义控件-------
    
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"commend"];
    
    _searchWord=[dic objectForKey:@"searchwords"];
    
   // NSLog(@"推荐输入内容是%@",_searchWord);
    

}

-(void)requsetData{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.farmTour.tour",@"areaId": [NSString stringWithFormat:@"%@",_areaID], @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1", @"keyword" : [NSString stringWithFormat:@"%@",_searchWord]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        self.datasModel = [CCSecondThredModel
                           mj_objectArrayWithKeyValuesArray:article];
        // NSLog(@"推荐搜索在线解析＝%@",responseObject);
        
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
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.farmTour.tour",@"areaId": [NSString stringWithFormat:@"%@",_areaID], @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1", @"keyword" : [NSString stringWithFormat:@"%@",_searchWord]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        self.datasModel = [CCSecondThredModel
                           mj_objectArrayWithKeyValuesArray:article];
        if (article==nil ) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"很抱歉，未搜索到所需内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [_secondTableView.mj_header endRefreshing];
            return;
            
        }

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

//------上拉加载更多-----

- (void)loadMoreData {
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.farmTour.tour",@"areaId": [NSString stringWithFormat:@"%@",_areaID], @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" :[NSString stringWithFormat:@"%zd",_curPage], @"keyword" : [NSString stringWithFormat:@"%@",_searchWord]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSArray *article = responseObject[@"article"];
        NSArray *dataArr = [CCSecondThredModel
                            mj_objectArrayWithKeyValuesArray:article];

        
        CCSecondThredModel *firstModel = [dataArr firstObject];
        CCSecondThredModel *lastModel = [self.datasModel lastObject];
        CCSecondThredModel *lastData = [dataArr lastObject];
        if ([firstModel.ids isEqualToString:lastModel.ids]||[lastModel.ids isEqualToString:lastData.ids]) {
            [_secondTableView.mj_footer endRefreshingWithNoMoreData];
           //[_secondTableView.mj_footer endRefreshing];
            
        } else {
            [_datasModel addObjectsFromArray:dataArr];
            [_secondTableView.mj_footer endRefreshing];
        }[_secondTableView.mj_header endRefreshing];
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
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
// NSLog(@"模型内容是＝＝＝＝%@",_secListmodel);
        [self setController:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}
-(void)setController:(id)responseObject{
    
    _secListWebViewController = [[CCSecListWebViewController alloc] init];
    _secListWebViewController.title=@"推荐路线";
    _secListWebViewController.url=_secondmodel.ids;
    _secListWebViewController.model=_secListmodel;
    

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
