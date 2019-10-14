//
//  CCRichViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCRichViewController.h"
#import <SDCycleScrollView.h>

#import "CCOneImageTableViewCell.h"
#import "CCThreeImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "CCAdDetailViewController.h"
#import "CCBaseNavViewController.h"
#import "CCSecListWebViewController.h"

static NSString *oneImageCell=@"CCOneImageTableViewCell";
static NSString *threeImageCell=@"CCThreeImageTableViewCell";


@interface CCRichViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *_redview;
    NSMutableArray *_imageUrls;
    NSMutableArray *_imageNames;
    NSString *_urlString;
    CCAdDetailViewController *_adDetailView;
    CCSecListWebViewController *_secListWebViewController;
   }
@property (nonatomic,strong)NSMutableArray *datasModel;
@property (nonatomic, strong) NSMutableArray *informations;
//@property (nonatomic, strong) UITableView *rich;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *informations2;
@property (nonatomic,assign) NSInteger curPage;

@end


@implementation CCRichViewController

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5.0/360.0*ScreenWidth ,45.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, 170.0/667.0*ScreenHeight) delegate:self placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        cycleScrollView.autoScrollTimeInterval=4;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView = cycleScrollView;
    }
    return _cycleScrollView;
}

- (NSMutableArray *)informations2 {
    if (!_informations2) {
        _informations2 = [NSMutableArray array];
    }
    return _informations2;
}


- (NSMutableArray *)datasModel {
    
    if (!_datasModel) {
        
        _datasModel = [NSMutableArray array];
    }
    
    return _datasModel;
}

- (NSMutableArray *)informations {
    if (!_informations) {
        _informations = [NSMutableArray array];
    }
    return _informations;
}

- (void)viewDidLoad {
    
        _rich=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 45.0/667.0*ScreenHeight, ScreenWidth, ScreenHeight - 164.0/667.0*ScreenHeight )];
    
    _rich.separatorStyle=UITableViewCellSeparatorStyleNone;
    _rich.bounces=YES;
//    [self requsetData];
    [self.view addSubview:_rich];
    [self requsetData1];
    _rich.delegate=self;
    _rich.dataSource=self;
    
    
    
    _curPage = 1;
    
    
    
    _rich.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _rich.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_rich.mj_header beginRefreshing];
}

//--------请求致富经下面部分信息
-(void)requsetData1{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.list.richClassics", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        //NSLog(@"致富经单元格＝responseObject==%@",responseObject);
        
        _informations = [CCSecondThredModel
                         mj_objectArrayWithKeyValuesArray:article];
        
        [_rich reloadData];
        
        _curPage = 2;
        [_rich.mj_header endRefreshing];
        [_rich.mj_footer endRefreshing];
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_rich.mj_header endRefreshing];
        [_rich.mj_footer endRefreshing];
    }];
    
}


-(void)loadNewData{
    NSURL *URL2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=ad.query.richClassics&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    manager2.responseSerializer =[AFJSONResponseSerializer serializer];
    manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager2 GET:URL2.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        // NSLog(@"请求成功＝＝JSON: %@", responseObject);
        
        NSArray *ad = responseObject[@"ad"];
        
        self.datasModel = [CCAdddModel
                           mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_richModel in self.datasModel) {
            
            [_imageUrls addObject:_richModel.adImage];
            [_imageNames addObject:_richModel.adName];
        }
        
        [self ScrollNetWorkImages];
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.list.richClassics", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        [self.informations removeAllObjects];
        
        _informations2 = [CCSecondThredModel
                         mj_objectArrayWithKeyValuesArray:article];
        [_rich reloadData];
        
        
        // _curPage = 2;
        [_rich.mj_header endRefreshing];
        [_rich.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_rich.mj_header endRefreshing];
        [_rich.mj_footer endRefreshing];
    }];
    
    
}

//------上拉加载更多-----

- (void)loadMoreData {
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.list.richClassics", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSArray *article = responseObject[@"article"];
        NSArray *dataArr = [CCSecondThredModel
                            mj_objectArrayWithKeyValuesArray:article];
        // [self.informations addObjectsFromArray:dataArr];
        
        //[self reloadData];
        
        CCSecondThredModel *firstModel = [dataArr firstObject];
        CCSecondThredModel *lastModel = [self.informations2 lastObject];
        CCSecondThredModel *lastData = [dataArr lastObject];
        if ([firstModel.ids isEqualToString:lastModel.ids]|| [lastModel.ids isEqualToString:lastData.ids]) {
            [_rich.mj_footer endRefreshingWithNoMoreData];
            //  [self.mj_footer endRefreshing];
            
        } else {
            [self.informations2 addObjectsFromArray:dataArr];
            [_rich.mj_footer endRefreshing];
        }
        [_rich.mj_header endRefreshing];
        [_rich reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_rich.mj_header endRefreshing];
        [_rich.mj_footer endRefreshing];
    }];
}




-(void)requsetData{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=ad.query.richClassics&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        // NSLog(@"请求成功＝＝JSON: %@", responseObject);
        
        NSArray *ad = responseObject[@"ad"];
        
        self.datasModel = [CCAdddModel
                           mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_richModel in self.datasModel) {
            
            [_imageUrls addObject:_richModel.adImage];
            [_imageNames addObject:_richModel.adName];
        }
        
        [self ScrollNetWorkImages];
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
}

-(void)ScrollNetWorkImages{
    
    
    self.cycleScrollView.titlesGroup = _imageNames;
    
    self.cycleScrollView.currentPageDotColor = AppMainColor; // 自定义分页控件小圆标颜色
    self.cycleScrollView.imageURLStringsGroup = _imageUrls;
    _rich.tableHeaderView = self.cycleScrollView;

    
    if (_richModel.video==NULL) {
        
    }else{
        UIImageView *adPlayImage=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-30.0/360.0*ScreenWidth)/2, (140.0/667.0*ScreenHeight)/2, 30.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
        adPlayImage.image=[UIImage imageNamed:@"banner_bofang"];
        [self.cycleScrollView addSubview:adPlayImage];
    }

    
    
    
    
}



//----轮播点击方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    _richModel=self.datasModel[index];
    
    self.cycleScrollView.userInteractionEnabled=NO;
    [self requestAdDetailData];
   
    _adDetailModel=self.datasModel[index];
}

//----------广告详情页网络请求-------
-(void)requestAdDetailData{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    //NSLog(@"Rich==%@",_richModel.associateId);
    _urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_richModel.associateId,ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"Rich请求成功＝＝JSON: %@", responseObject);
        _adDetailModel=[[CCAdDetailModel alloc]init];
        _adDetailModel=[CCAdDetailModel mj_objectWithKeyValues:responseObject];
        //NSLog(@"视屏链接＝＝%@",_adDetailModel.video);
        // NSLog(@"视屏链接＝＝%@",_adDetailModel.title);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setAdController:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}
-(void)setAdController:(id)responseObject{
    
    _adDetailView = [[CCAdDetailViewController alloc] init];    //_adDetailView.url= _urlString;
    _adDetailView.url=_richModel.associateId;
    _adDetailView.model=_adDetailModel;
    _adDetailView.title=@"致富经";

    [self.navigationController pushViewController:_adDetailView animated:YES];
    
    
    
    
}
#pragma mark - //

//------------单元格代理




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.row%2==0) {
    
    
    return 87;
    
    //    }else
    //        return 145;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _informations2.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _inforModel=self.informations2[indexPath.row];
    _rich.userInteractionEnabled=NO;
    [self requestData2];
    
    
}


-(void)requestData2{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    NSString *urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_inforModel.ids,ids];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        // NSLog(@"详情请求成功＝＝JSON: %@", responseObject);
        _model=[[CCSecListModel  alloc]init];
        _model=[CCSecListModel mj_objectWithKeyValues:responseObject];
        // NSLog(@"模型内容是＝＝＝＝%@",_secListmodel);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setController:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
}

-(void)setController:(id)responseObject{
    
    _secListWebViewController = [[CCSecListWebViewController alloc] init];
    _secListWebViewController.url=_inforModel.ids;
    _secListWebViewController.title=@"致富经";
    _secListWebViewController.model=_model;
    
   // CCBaseNavViewController *SecondController = [[CCBaseNavViewController alloc]initWithRootViewController:_secListWebViewController];
    
    [self.navigationController pushViewController:_secListWebViewController animated:YES];
    
    
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CCOneImageTableViewCell *grayCell=[tableView dequeueReusableCellWithIdentifier:oneImageCell];
    //    CCThreeImageTableViewCell *whiteCell=[tableView dequeueReusableCellWithIdentifier:threeImageCell];
    
    //    if (indexPath.row%2==0) {
    if (grayCell==nil) {
        grayCell=[CCOneImageTableViewCell setOneImageCell];
        // grayCell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kuaijie_line_hengxian"]];
        
    }
    grayCell.inforModel=_informations2[indexPath.row];
    return grayCell;
    
    //    }else if(whiteCell==nil){
    //        whiteCell=[CCThreeImageTableViewCell setThreeImageCell];
    //    }
    //    return whiteCell;
    //
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.cycleScrollView.userInteractionEnabled=YES;
    _rich.userInteractionEnabled=YES;
    if (self.miroFilm) {
        
        
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        _redview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        _redview.userInteractionEnabled=YES;
        _redview.backgroundColor=CCColor(31, 172, 63);;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIButton *btns = [UIButton buttonWithType:UIButtonTypeSystem];
        btns.frame = CGRectMake(18.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
        [btns setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btns addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_redview addSubview:btns];
        UILabel *mylable=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-60)/2, 28, 70, 25)];
        mylable.text=@"致富经";
        mylable.textColor=[UIColor whiteColor];
        [_redview addSubview:mylable];
        [window addSubview:_redview];
        
    }

}
- (void)viewWillDisappear:(BOOL)animated {
    
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [_redview removeFromSuperview];
}
-(void)back{
    [_redview removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
