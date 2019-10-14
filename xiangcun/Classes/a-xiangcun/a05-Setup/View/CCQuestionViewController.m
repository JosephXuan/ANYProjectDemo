//
//  CCQuestionViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/28.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCQuestionViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCQuestTableViewCell.h"
#import "MJRefresh.h"

static NSString *qusetionsCell=@"CCQuestTableViewCell";
@interface CCQuestionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CCQuestTableViewCell *_question;
    UITableView *_tableView;
    
}
@property (nonatomic,assign) NSInteger curPage;
@property (nonatomic,strong)NSMutableArray *data;
@end

@implementation CCQuestionViewController

- (NSMutableArray *)data {
    
    if (!_data) {
        
        _data = [NSMutableArray array];
    }
    
    return _data;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0, 0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self requestData];
    [self setTableview];
    _curPage=1;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_tableView.mj_header beginRefreshing];

}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

-(void)requestData{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=query.problemss.list&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
     //  NSLog(@"常见问题请求成功,liebiaoxinxi＝＝JSON: %@", responseObject);
        
        NSArray *problemsList = responseObject[@"problemsList"];
        
        
        
        
       self.data = [CCNoticDetailModel
                        mj_objectArrayWithKeyValuesArray:problemsList];
     
        
        
        [_tableView reloadData];
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

}
-(void)setTableview{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, ScreenHeight)];
    
    _tableView.delegate=self;
    
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark - 下拉刷新
-(void)loadNewData{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.problemss.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *problemsList = responseObject[@"problemsList"];
        //[self.data removeAllObjects];
       // [_tableView removeFromSuperview];
        self.data = [CCNoticDetailModel
                         mj_objectArrayWithKeyValuesArray:problemsList];
        [_tableView reloadData];
        
        
        _curPage = 2;
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
    
}

//------上拉加载更多-----

- (void)loadMoreData {
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.problemss.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSLog(@"第N个模型的id＝%@",responseObject);
        NSArray *problemsList = responseObject[@"problemsList"];
        NSArray *dataArr = [CCNoticDetailModel
                            mj_objectArrayWithKeyValuesArray:problemsList];
        
        CCNoticDetailModel *firstModel = [dataArr firstObject];
        CCNoticDetailModel *lastModel = [self.data lastObject];
        CCNoticDetailModel *lastData = [dataArr lastObject];
        NSLog(@"第一个模型的id＝%@",firstModel.ids);
         NSLog(@"第二个模型的id＝%@",lastModel.ids);
         NSLog(@"第三个模型的id＝%@",lastData.ids);
        if ([firstModel.ids isEqualToString:lastModel.ids]||
            [lastModel.ids isEqualToString:lastData.ids]) {
           
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            //  [self.mj_footer endRefreshing];
            
        } else {
            [_data addObjectsFromArray:dataArr];
            [_tableView.mj_footer endRefreshing];
        }
        [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}


//②③

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0/667.0*ScreenHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _question=[tableView dequeueReusableCellWithIdentifier:qusetionsCell];
    
    
    
    if (_question==nil) {
        
        _question=[[CCQuestTableViewCell alloc]init];
        
    }_question.questionModel=self.data[indexPath.row];
    //NSLog(@"单元格里面模型内容%@",_tourCell.inforModel);
    
    return _question;

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
