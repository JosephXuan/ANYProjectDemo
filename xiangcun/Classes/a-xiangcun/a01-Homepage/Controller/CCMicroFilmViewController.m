//
//  CCMicroFilmViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCMicroFilmViewController.h"
#import <SDCycleScrollView.h>
#import "CCInformationCell.h"
#import "CCInformationModel.h"
#import "CCInformationHeader.h"
#import "CCWebViewController.h"
#import "CCBaseNavViewController.h"
#import "CCAdDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface CCMicroFilmViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *_imageUrls;
    NSMutableArray *_imageNames;
    NSString *_urlString;
    UICollectionView *_informationList;
    CCWebViewController *_webViewController;
    CCAdDetailViewController *_adDetailView;
    UIScrollView *_bgScrollerView;
    SDCycleScrollView *_cycleScrollView;
}
@property (nonatomic, strong) NSMutableArray *informations;
@property (nonatomic,strong)NSMutableArray *datasModel;
@property (nonatomic, strong) NSMutableArray *micFim;

@end

@implementation CCMicroFilmViewController

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
    [super viewDidLoad];
   
    _bgScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight)];
    
    _bgScrollerView.userInteractionEnabled=YES;
    [self.view addSubview:_bgScrollerView];
    
    [self requsetData];
    [self requsetData1];
    
    _bgScrollerView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [_bgScrollerView.mj_header beginRefreshing];
   
//#pragma mark - 代替展示模块
//    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight-44.0/667.0*ScreenHeight)];
//    bgImage.userInteractionEnabled=NO;
//    bgImage.image=[UIImage imageNamed:@"zhengzaijianshe"];
//    [self.view addSubview:bgImage];
}

//----下拉刷新-----
-(void)loadNewData{
    
    //-----刷新广告部分请求－－
    
    NSURL *URL = [NSURL URLWithString:@"http://218.94.69.194/mobile/router"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"ad.query.microFilm", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *ad = responseObject[@"ad"];
        [_cycleScrollView removeFromSuperview];
        self.datasModel = [CCAdddModel
                           mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_microModel in self.datasModel) {
            //  NSLog(@"首页广告视频－＝%@",_model.video);
            
            [_imageUrls addObject:_microModel.adImage];
            [_imageNames addObject:_microModel.adName];
        }
        
        
        [self ScrollNetWorkImages];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
//-----刷新collection view部分
    NSMutableDictionary *parameters2 = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.index.microFilm", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters2 success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        // NSLog(@"responseObject==%@",responseObject);
        
        
        
        _informations = [CCInformationModel
                         mj_objectArrayWithKeyValuesArray:article];
        //NSDictionary *
        [_informationList reloadData];
        
        
        
        [_bgScrollerView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_bgScrollerView.mj_header endRefreshing];
    }];
    
    
}




//-----下半部分视图
- (void)addCollectionView {
    
    _bgScrollerView.contentSize=CGSizeMake(ScreenWidth, ((_informations.count/2)*((ScreenWidth - 30.0/360.0*ScreenWidth)/2))+400.0/667.0*ScreenHeight);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 3.0/360.0*ScreenWidth;
    layout.minimumInteritemSpacing=15;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 40.0/667.0*ScreenHeight);
    
    //layout.sectionInset = UIEdgeInsetsMake(5, 15, 5, 15);
    
    layout.itemSize = CGSizeMake((ScreenWidth - 40.0/360.0*ScreenWidth)/2, (ScreenWidth - 30.0/360.0*ScreenWidth)/2);
    _informationList = nil;
    
    if (self.miroFilm) {
        _informationList =   [[UICollectionView alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 225.0/667.0*ScreenHeight, ScreenWidth - 20.0/360.0*ScreenWidth, ((_informations.count/2)*((ScreenWidth - 30.0/360.0*ScreenWidth)/2)+300.0/667.0*ScreenHeight)) collectionViewLayout:layout];
        
    } else {
        _informationList =   [[UICollectionView alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 225.0/667.0*ScreenHeight, ScreenWidth - 20.0/360.0*ScreenWidth, ((_informations.count/2)*((ScreenWidth - 30.0/360.0*ScreenWidth)/2)+300.0/667.0*ScreenHeight)) collectionViewLayout:layout];
    }
//    [self.view addSubview:_informationList];
    _informationList.scrollEnabled=NO;
    _informationList.backgroundColor = [UIColor clearColor];
    [_informationList registerClass:[CCInformationCell class] forCellWithReuseIdentifier:@"infomationCell"];
    [_informationList registerClass:[CCInformationHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"infomationHeader"];
    _informationList.delegate = self;
    _informationList.dataSource = self;
    _informationList.showsVerticalScrollIndicator = NO;
    _informationList.showsHorizontalScrollIndicator = NO;
    [_bgScrollerView addSubview:_informationList];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    _microModel=self.datasModel[index];
//NSLog(@"---点击了第%ld张图片", (long)index);
    [self requestAdDetailData];
    _adDetailModel=self.datasModel[index];
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CCInformationHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"infomationHeader" forIndexPath:indexPath];
        header.inforImage.image = [UIImage imageNamed:@"icon_meiwei"];
        header.titleLabel.text = @"美味推荐";
        header.subTitle.text = @"更多美味";
        header.arrowImage.image = [UIImage imageNamed:@"btn_more"];
        header.subTitle.userInteractionEnabled=YES;
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 182.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
        
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(secondController) forControlEvents:UIControlEventTouchUpInside];
        
        [header.subTitle addSubview:button];
        
        return header;
    }
    return nil;
}

-(void)secondController{
    UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCSeMicroFilmViewController" bundle:nil] instantiateInitialViewController];
    [self presentViewController:SecondController animated:YES completion:nil];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//----首页单元格数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _informations.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CCInformationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"infomationCell" forIndexPath:indexPath];
    cell.infomationModel =_informations[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _inforModel=self.informations[indexPath.item];
    [self requestDetailData];
    
    
}
//-----跳转collectinview详情请求-----
-(void)requestDetailData{
 NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
 NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    _urlString=[NSString stringWithFormat:@"http://218.94.69.194/mobile/router?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",_inforModel.ids,ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"请求成功跳转详情＝＝JSON: %@", responseObject);
        _detailModel=[[CCDetailModel alloc]init];
        _detailModel=[CCDetailModel mj_objectWithKeyValues:responseObject];
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setController:responseObject];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}

-(void)setController:(id)responseObject{
    
    _webViewController = [[CCWebViewController alloc] init];    _webViewController.url= _inforModel.ids;
    _webViewController.title=@"乡村美味";
    _webViewController.model=_detailModel;
    
//    CCBaseNavViewController *SecondController = [[CCBaseNavViewController alloc]initWithRootViewController:_webViewController];
    [self.navigationController pushViewController:_webViewController animated:YES];
    
    
    
    
    
}

//-----首页广告信息请求--------
-(void)requsetData{
    
    NSURL *URL = [NSURL URLWithString:@"http://218.94.69.194/mobile/router?method=ad.query.microFilm&appKey=w4q897jgvxkb&v=1.0&format=json"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
       // NSLog(@"乡村美味请求成功＝＝JSON: %@", responseObject);
        
        NSArray *ad = responseObject[@"ad"];
        
        self.datasModel = [CCAdddModel
                           mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_microModel in self.datasModel) {
            //  NSLog(@"首页广告视频－＝%@",_model.video);
            
            [_imageUrls addObject:_microModel.adImage];
            [_imageNames addObject:_microModel.adName];
        }
        
        
        [self ScrollNetWorkImages];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

}

-(void)ScrollNetWorkImages{
 
   _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5.0/360.0*ScreenWidth,45.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, 170.0/667.0*ScreenHeight) delegate:self placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
    if ([_microModel.video isEqualToString:@""]) {
        
    }else{
        UIImageView *adPlayImage=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-30.0/360.0*ScreenWidth)/2, (140.0/667.0*ScreenHeight)/2, 30.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
        adPlayImage.image=[UIImage imageNamed:@"banner_bofang"];
        [_cycleScrollView addSubview:adPlayImage];
    }
    
    // NSLog(@"轮播图片的的链接=%@",_imageUrls);
    
    //cycleScrollView.delegate = self;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.titlesGroup = _imageNames;
    // NSLog(@"轮播的文字=%@",_imageNames);
    _cycleScrollView.currentPageDotColor = AppMainColor; // 自定义分页控件小圆标颜色
    _cycleScrollView.imageURLStringsGroup = _imageUrls;
    [_bgScrollerView addSubview:_cycleScrollView];
    
    
    
}



//-------首页下方xollectionview数据请求------
-(void)requsetData1{
    
    NSURL *URL = [NSURL URLWithString:@"http://218.94.69.194/mobile/router?method=article.index.microFilm&appKey=w4q897jgvxkb&v=1.0&format=json"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"请求成功,liebiaoxinxi＝＝JSON: %@", responseObject);
        
        NSArray *article = responseObject[@"article"];
        // NSLog(@"responseObject==%@",responseObject);
        
        
        
        _informations = [CCInformationModel
                         mj_objectArrayWithKeyValuesArray:article];
        //NSDictionary *
        [self addCollectionView];
        [_informationList reloadData];
        
        
        
        //NSLog(@"首页模型内容 %@",_informations);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

//----------广告详情页网络请求-------
-(void)requestAdDetailData{
 NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
 NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    _urlString=[NSString stringWithFormat:@"http://218.94.69.194/mobile/router?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",_microModel.associateId,ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"乡村美味广告详情页请求成功＝＝JSON: %@", responseObject);
        _adDetailModel=[[CCAdDetailModel alloc]init];
        _adDetailModel=[CCAdDetailModel mj_objectWithKeyValues:responseObject];
        //NSLog(@"视屏链接＝＝%@",_adDetailModel.video);
//NSLog(@"视屏链接＝＝%@",_adDetailModel.title);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setAdController:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}

-(void)setAdController:(id)responseObject{
    
    _adDetailView = [[CCAdDetailViewController alloc] init];    //
    _adDetailView.url=_microModel.associateId;
 _adDetailView.model=_adDetailModel;
    _adDetailView.title=@"乡村美味";
    
    [self.navigationController pushViewController:_adDetailView animated:YES];
    
    
    
    
    
}



- (NSMutableArray *)micFim {
    if (_micFim == nil) {
        _micFim = [NSMutableArray array];
    }
    return _micFim;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
