//
//  CCNewTrendViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCNewTrendViewController.h"
#import <SDCycleScrollView.h>
#import "UIBarButtonItem+Item.h"
#import "SXMarquee.h"
#import "CCInformationCell.h"
#import "CCInformationModel.h"
#import "CCInformationHeader.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCWebViewController.h"
#import "CCBaseNavViewController.h"
#import "CCAdDetailViewController.h"
#import "CCNoticDeWebViewController.h"
#import "MJRefresh.h"
//#import "PPNetworkHelper.h"

@interface CCNewTrendViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>


{
    UIView *_redview;
    SDCycleScrollView *_cycleScrollView;
    NSMutableArray *_imageUrls;
    NSMutableArray *_imageNames;
    NSMutableArray *_firstImageUrls;
    NSMutableArray *_firstTitleNames;
    NSMutableArray *_firstDesNames;
    NSString *_noticString;
    UICollectionView *_informationList;//CCInformationCell *_cell;
    UIImageView *_xiaoxiView;
    UIButton *_scButton;
    NSString *_urlString;
CCWebViewController *_webViewController;//下方collectionview详情页
CCAdDetailViewController *_adDetailView;//广告详情页
    CCNoticDeWebViewController *_noticDetaliWebView;//公告详情页
    UIScrollView *_bgScrollerView;
    UILabel *_noticLab;
    
}
@property (nonatomic, strong) NSMutableArray *informations;
@property (nonatomic, strong) SXMarquee *mar;
@property (nonatomic,strong)NSMutableArray *datasModel;
@property (nonatomic,strong)NSMutableArray *notic;
@end

@implementation CCNewTrendViewController

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

- (NSMutableArray *)notic {
    if (!_notic) {
        _notic = [NSMutableArray array];
    }
    return _notic;
}

- (void)viewDidLoad {
    [super viewDidLoad];

     NSLog(@"沙河路径%@",NSHomeDirectory());
    if (self.miroFilm) {
        _bgScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight)];
    }else{
     _bgScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0.0, 5.0/667.0*ScreenHeight, ScreenWidth, ScreenHeight)];
    }
    _bgScrollerView.userInteractionEnabled=YES;
    _noticLab=[[UILabel alloc]init];
    _noticLab.text=@"请点击更多查看";
    _noticLab.font=[UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    [self.view addSubview:_bgScrollerView];
    [_bgScrollerView addSubview:_noticLab];
    [self requsetData];
    [self requsetData1];
    //[self addScrollText];
    
    
    _bgScrollerView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [_bgScrollerView.mj_header beginRefreshing];

}
-(void)back{
    [_redview removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//----下拉刷新-----
-(void)loadNewData{
    
//-----刷新广告部分请求－－
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"ad.query.newTrends", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {

        NSArray *ad = responseObject[@"ad"];

        [_cycleScrollView removeFromSuperview];
               self.datasModel = [CCAdddModel
                           mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_model in self.datasModel) {
            
            
            [_imageUrls addObject:_model.adImage];
            [_imageNames addObject:_model.adName];
        }
        [self ScrollNetWorkImages];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
//------刷新公告部分
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"notice.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters1 success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"刷新公告==%@",responseObject);
#pragma mark --刷新前先移除控件，避免重复创建
        [_xiaoxiView removeFromSuperview];
        [_scButton removeFromSuperview];
        [self.mar removeFromSuperview];

        NSArray *noticeList = responseObject[@"noticeList"];
            NSDictionary *dic=[[NSDictionary alloc]init];
        dic=noticeList[0];
        _noticModel=[CCNoticModel mj_objectWithKeyValues:dic];
        
        
        [self addScrollText];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
//-----刷新collection view部分
    NSMutableDictionary *parameters2 = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.index.newTrends", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters2 success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
       
        
        _informations = [CCInformationModel
                         mj_objectArrayWithKeyValuesArray:article];
        if (self.miroFilm) {
            _bgScrollerView.contentSize=CGSizeMake(ScreenWidth, ((300.0/667.0*ScreenHeight)+((_informations.count/2)+0.8)*((ScreenWidth - 25)/2)));
        }else{
        _bgScrollerView.contentSize=CGSizeMake(ScreenWidth, ((215.0/667.0*ScreenHeight)+((_informations.count/2)+0.8)*((ScreenWidth - 25)/2)));
        }
        _noticLab.frame=CGRectMake((ScreenWidth-140.0/360.0*ScreenWidth)/2, ((170.0/667.0*ScreenHeight)+((_informations.count/2)+0.8)*((ScreenWidth - 25)/2)), 140.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight);
        [self addCollectionView];
        [_informationList reloadData];
        
        
        [_bgScrollerView.mj_header endRefreshing];
        
       
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_bgScrollerView.mj_header endRefreshing];
    }];


    
}

//-----下半部分视图-----
- (void)addCollectionView {
    [_informationList removeFromSuperview];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 3.0/360.0*ScreenWidth;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 40.0/667.0*ScreenHeight);


    layout.itemSize = CGSizeMake((ScreenWidth - 40.0/360.0*ScreenWidth)/2, (ScreenWidth - 30.0/360.0*ScreenWidth)/2);                     //260
    _informationList = [[UICollectionView alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 260.0/667.0*ScreenHeight, ScreenWidth - 20.0/360.0*ScreenWidth, ((_informations.count/2)+0.5)*((ScreenWidth - 30.0/360.0*ScreenWidth)/2)) collectionViewLayout:layout];//370
    _informationList.scrollEnabled=NO;
    [_bgScrollerView addSubview:_informationList];
    _informationList.backgroundColor = [UIColor clearColor];
    [_informationList registerClass:[CCInformationCell class] forCellWithReuseIdentifier:@"infomationCell"];
    [_informationList registerClass:[CCInformationHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"infomationHeader"];
    _informationList.delegate = self;
    _informationList.dataSource = self;
    _informationList.showsVerticalScrollIndicator = NO;
    _informationList.showsHorizontalScrollIndicator = NO;
    [_bgScrollerView addSubview:_informationList];
    
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    _model=self.datasModel[index];
    _cycleScrollView.userInteractionEnabled=NO;
    [self requestAdDetailData];
    _bgScrollerView.userInteractionEnabled=NO;
    _adDetailModel=self.datasModel[index];
   
}

//-----滚动字幕－－－
- (void)addScrollText {//223
    _xiaoxiView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 225.0/667.0*ScreenHeight, 23.0/360.0*ScreenWidth, 23.0/667.0*ScreenHeight)];
    _xiaoxiView.image = [UIImage imageNamed:@"btn_xiaoxi"];
    [_bgScrollerView addSubview:_xiaoxiView];//220
    SXMarquee *mar = [[SXMarquee alloc]initWithFrame:CGRectMake(35.0/360.0*ScreenWidth, 220.0/667.0*ScreenHeight, ScreenWidth-36.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight) speed:4 Msg:_noticModel.title bgColor:[UIColor whiteColor] txtColor:CCColorString(@"#222222")];
   // NSLog(@"_noticModel.firstPage value: %@" ,_noticModel.firstPage?@"YES":@"NO");
    [mar changeMarqueeLabelFont:[UIFont systemFontOfSize:16.0/360.0*ScreenWidth]];
    [mar changeTapMarqueeAction:nil];
    [mar start];
    
   _scButton=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth-30.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
    _scButton.backgroundColor=[UIColor clearColor];
    [_scButton addTarget:self  action:@selector(scButoonAction) forControlEvents:UIControlEventTouchUpInside];
    [mar addSubview:_scButton];
    self.mar = mar;
    [_bgScrollerView addSubview:mar];
    
}

-(void)scButoonAction{
    _bgScrollerView.userInteractionEnabled=NO;
    [self requsetNoticData];
}

-(void)requsetNoticData{
    
        NSString *string=[NSString stringWithFormat:@"%@?method=notice.info&appKey=w4q897jgvxkb&v=1.0&format=json&noticeId=%@",KURL,_noticModel.ids];
//NSLog(@"_noticModel.ids=%@",_noticModel.ids);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:string parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        _noticDetailModel=[CCNoticDetailModel mj_objectWithKeyValues:responseObject];
       // NSLog(@"请求公告成功跳转详情＝＝JSON: %@", _noticDetailModel);
       
        [self setNoticController:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
            
        }

-(void)setNoticController:(id)responseObject{
    
    _noticDetaliWebView = [[CCNoticDeWebViewController alloc] init];
    _noticDetaliWebView.url=_noticModel.ids;
    _noticDetaliWebView.model=_noticDetailModel;
    

    [self.navigationController pushViewController:_noticDetaliWebView animated:YES];
    
    
    
    
    
}
    



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CCInformationHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"infomationHeader" forIndexPath:indexPath];
        header.inforImage.image = [UIImage imageNamed:@"btn_zixun"];
        header.titleLabel.text = @"农业动态";
        header.subTitle.text = @"更多动态";
        header.subTitle.userInteractionEnabled=YES;
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 182.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
        
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(secondController) forControlEvents:UIControlEventTouchUpInside];
        
        [header.subTitle addSubview:button];
        
        header.arrowImage.image = [UIImage imageNamed:@"btn_more"];
        
        
        return header;
    }
    return nil;
}



-(void)secondController{
    UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"SecondNewThred" bundle:nil] instantiateInitialViewController];
    [self presentViewController:SecondController animated:YES completion:nil];
    
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

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
    _informationList.userInteractionEnabled=NO;
    _bgScrollerView.userInteractionEnabled=NO;
    [self requestDetailData];

    
}


//-----跳转详情页面网络请求-----
-(void)requestDetailData{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    _urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_inforModel.ids,ids];
    
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
    
    _webViewController = [[CCWebViewController alloc] init];
    _webViewController.url= _inforModel.ids;
    _webViewController.title=@"新动向";
    _webViewController.model=_detailModel;
    

    [self.navigationController pushViewController:_webViewController animated:YES];

    
   
    
}

//-----首页广告信息请求--------
-(void)requsetData{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=ad.query.newTrends&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
       //NSLog(@"请求成功＝＝JSON: %@", responseObject);
        
        NSArray *ad = responseObject[@"ad"];
        
        self.datasModel = [CCAdddModel
                mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_model in self.datasModel) {
         
            
             [_imageUrls addObject:_model.adImage];
            [_imageNames addObject:_model.adName];
        }
        
        
        [self ScrollNetWorkImages];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
   
        
    
    
}

-(void)ScrollNetWorkImages{
    
    
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5.0/360.0*ScreenWidth ,45.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, 170.0/667.0*ScreenHeight) delegate:self placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
    _cycleScrollView.autoScrollTimeInterval=4;
    if (_model.video==NULL) {
        
        
    }else{
        UIImageView *adPlayImage=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-30.0/360.0*ScreenWidth)/2, (140.0/667.0*ScreenHeight)/2, 30.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
        adPlayImage.image=[UIImage imageNamed:@"banner_bofang"];
        [_cycleScrollView addSubview:adPlayImage];
        
    }
    
    
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.titlesGroup = _imageNames;
    // NSLog(@"轮播的文字=%@",_imageNames);
    _cycleScrollView.currentPageDotColor = AppMainColor; // 自定义分页控件小圆标颜色
    _cycleScrollView.imageURLStringsGroup = _imageUrls;
    [_bgScrollerView addSubview:_cycleScrollView];
    
    
    
}



//-------首页下方xollectionview数据请求------
-(void)requsetData1{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=article.index.newTrends&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
      // NSLog(@"请求成功,liebiaoxinxi＝＝JSON: %@", responseObject);
       
        NSArray *article = responseObject[@"article"];
       
        
        
        
       _informations = [CCInformationModel
                           mj_objectArrayWithKeyValuesArray:article];
      
        if (self.miroFilm) {
             _bgScrollerView.contentSize=CGSizeMake(ScreenWidth, ((300.0/667.0*ScreenHeight)+((_informations.count/2)+0.8)*((ScreenWidth - 25)/2)));
        }else{
             _bgScrollerView.contentSize=CGSizeMake(ScreenWidth, ((215.0/667.0*ScreenHeight)+((_informations.count/2)+0.8)*((ScreenWidth - 25)/2)));
        }
       
        _noticLab.frame=CGRectMake((ScreenWidth-140.0/360.0*ScreenWidth)/2, ((170.0/667.0*ScreenHeight)+((_informations.count/2)+0.8)*((ScreenWidth - 25)/2)), 140.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight);
        [self addCollectionView];
        
        
        [_informationList reloadData];
        
        
        

        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

//--------请求公告数据---------
    NSURL *noticURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=notice.list&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer =[AFJSONResponseSerializer serializer];
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager1 GET:noticURL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray *noticeList = responseObject[@"noticeList"];
    //    NSLog(@"公告数据＝responseObject=Notic==%@",responseObject);
        
    
        
        NSDictionary *dic=[[NSDictionary alloc]init];
        dic=noticeList[0];
        _noticModel=[CCNoticModel mj_objectWithKeyValues:dic];
       
        
                [self addScrollText];
       
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
  
    
}
//----------广告详情页网络请求-------
-(void)requestAdDetailData{
    
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    _urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_model.associateId,ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        // NSLog(@"请求成功＝＝JSON: %@", responseObject);
        _adDetailModel=[[CCAdDetailModel alloc]init];
        _adDetailModel=[CCAdDetailModel mj_objectWithKeyValues:responseObject];
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        
        [self setAdController:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}

-(void)setAdController:(id)responseObject{
    
    _adDetailView = [[CCAdDetailViewController alloc] init];
    _adDetailView.url=_model.associateId;
//    NSLog(@"_url===%@",_adDetailView.url);
    _adDetailView.model=_adDetailModel;
    
   
     _adDetailView.title=@"新动向";

    
    [self.navigationController pushViewController:_adDetailView animated:YES];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mar stop];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [_redview removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _bgScrollerView.userInteractionEnabled=YES;
    _informationList.userInteractionEnabled=YES;
    _cycleScrollView.userInteractionEnabled=YES;
    [self.mar start];
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
        mylable.text=@"新动向";
        mylable.textColor=[UIColor whiteColor];
        [_redview addSubview:mylable];
        [window addSubview:_redview];
        
    }
       
}



@end
