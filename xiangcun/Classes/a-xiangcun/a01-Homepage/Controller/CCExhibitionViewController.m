//
//  CCExhibitionViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCExhibitionViewController.h"
#import "CCHistroyTableViewCell.h"
#import "CCNowTableViewCell.h"
#import "CCExihibitioningTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "CCSecListWebViewController.h"
#import "CCMapViewController.h"
#import "CCBaseNavViewController.h"
@interface CCExhibitionViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    UIView *_redview;
    UIImageView *_scrollerView;
    NSArray *_buttonName;
    UIButton *_Abutton;
    UIImageView *_bgImage;
    UIImageView *_tjImage;
    UIView *_lineImage1;
    UIView *_lineImage2;
    UIView *_lineImage3;
    UIView *_lineImage4;
    NSMutableArray *_buttonColor;
    
    UITableView *_nowTableView;
    CCHistroyTableViewCell *_hidtroyCell;
    CCNowTableViewCell *_nowCell;
    CCExihibitioningTableViewCell*_exihiCell;
    NSInteger _lastBtn;
    UIScrollView *_scroller;
    UIScrollView *_nzgjieshao;
    CCSecListWebViewController *_secListWebViewController;
    NSString *_buildDesc;
}
@property (nonatomic, strong) NSMutableArray *willExihibitions;
@property (nonatomic,strong)NSMutableArray *historyExibitions;
@property (nonatomic,strong)NSMutableArray *exihibitionings;
@property (nonatomic,assign) NSInteger curPage;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *adress;
@property (nonatomic, strong) UILabel *bigTitle;
@property (nonatomic, strong) UILabel *smallTitke;
@property (nonatomic, strong) UILabel *numberLable;
@property (nonatomic, strong) UILabel *descripitions;
@property (nonatomic,strong) UIScrollView *contentView;
@end



@implementation CCExhibitionViewController
- (NSMutableArray *)exihibitionings {
    
    if (!_exihibitionings) {
        
        _exihibitionings = [NSMutableArray array];
    }
    
    return _exihibitionings;
}
- (NSMutableArray *)willExihibitions {
    
    if (!_willExihibitions) {
        
        _willExihibitions = [NSMutableArray array];
    }
    
    return _willExihibitions;
}
- (NSMutableArray *)historyExibitions {
    if (!_historyExibitions) {
        _historyExibitions = [NSMutableArray array];
    }
    return _historyExibitions;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CCColor(235, 235, 235);
    [self requestNowData];
     [self setNowExihibition];
    
    [self requestNZG];
    [self addTitleView];
    [self addButton];
    
    

}



-(void)requestNZG{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.buildInfo", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
       // NSLog(@"展馆详情请求成功,liebiaoxinxi＝＝JSON: %@", responseObject);
        
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"NZGdetail"];
       
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

}
//=---==-数据请求部分－－－－
-(void)requestNowData{
    NSURL *URL = [NSURL URLWithString:@"http://218.94.69.194/mobile_test/router"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.progress", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"正在展出请求成功,liebiaoxinxi＝＝JSON: %@", responseObject);
        
        
        NSArray *article = responseObject[@"article"];
        // NSLog(@"responseObject==%@",responseObject);
        
        self.exihibitionings  = [CCNowExihibitionModel
                                  mj_objectArrayWithKeyValuesArray:article];
        
        [_exihibitioning reloadData];
        
       
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
}

-(void)requestWillData{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.open", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"即将展出请求成功,liebiaoxinxi＝＝JSON: %@", responseObject);
        
        NSArray *article = responseObject[@"article"];
       
        
        self.willExihibitions  = [CCWillExihibitionModel
         mj_objectArrayWithKeyValuesArray:article];
        
         [_nowTableView reloadData];

        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
}
-(void)requestHistoryData{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.previous", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"即将展出请求成功,liebiaoxinxi＝＝JSON: %@", responseObject);
        
        NSArray *article = responseObject[@"article"];
        
        
        self.historyExibitions  = [CCHistoryExihibitionModel
                                  mj_objectArrayWithKeyValuesArray:article];
        
        [_histroyTableView reloadData];
       
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}
//--------正在展出部分-------

-(void)setNowExihibition{
    _exihibitioning=[[UITableView alloc]init];
    if (self.exihibition) {
        _exihibitioning.frame=CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+22.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight)-130.0/667.0*ScreenHeight);
    }else{
   _exihibitioning.frame=CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+22.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-(ScreenHeight-305.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight));
    }
    _exihibitioning.separatorStyle = NO;
    _exihibitioning.tag=2000;
    _exihibitioning.delegate=self;
    _exihibitioning.dataSource=self;
    [self.view addSubview:_exihibitioning];
    
    _curPage = 1;
    
    
    _exihibitioning.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewExihibiData)];
    [_exihibitioning.mj_header beginRefreshing];
  }

//----下拉刷新正在展出-----
-(void)loadNewExihibiData{
    NSURL *URL = [NSURL URLWithString:@"http://218.94.69.194/mobile_test/router"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.progress", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        [self.exihibitionings removeAllObjects];
        self.exihibitionings = [CCNowExihibitionModel
                                 mj_objectArrayWithKeyValuesArray:article];
        if (article==nil) {
            
            UILabel *lable=[[UILabel alloc]init];
            lable.frame=CGRectMake(80.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, 100.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight);
            lable.text=@"暂无展会";
            
            [_exihibitioning addSubview:lable];
           
            
            
            
            
        }
//         [_exihibitioning.mj_header endRefreshing];
        [_exihibitioning reloadData];
        _curPage = 2;
        [_exihibitioning.mj_header endRefreshing];
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_exihibitioning.mj_header endRefreshing];
       
    }];

        

}

#pragma mark --上半部分
-(void)addTitleView{
    UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0, 42.0/667.0*ScreenHeight, ScreenWidth, 201.0/667.0*ScreenHeight)];
    contentView.backgroundColor = CCColor(235, 235, 235);
    contentView.contentSize=CGSizeMake(ScreenWidth, 220.0/667.0*ScreenHeight);
    self.contentView=contentView;
    self.contentView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewdetailData)];
       [self.contentView.mj_header beginRefreshing];
    [self.view addSubview:self.contentView];
    
    UIView *bgView1=[[UIView alloc]initWithFrame:CGRectMake(0.0, 10.0/667.0*ScreenHeight, ScreenWidth, 100.0/667.0*ScreenHeight)];
    bgView1.backgroundColor=[UIColor whiteColor];
    [contentView addSubview:bgView1];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, 84.0/360.0*ScreenWidth, 84.0/667.0*ScreenHeight)];
    self.imageView=imageView;
    
    imageView.layer.cornerRadius=42.0/667.0*ScreenHeight;
    imageView.layer.masksToBounds=YES;
    [bgView1 addSubview:imageView];
    
    UILabel *bigTitle=[[UILabel alloc]initWithFrame:CGRectMake(119.0/360.0*ScreenWidth, 13.0/667.0*ScreenHeight, 200.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    self.bigTitle=bigTitle;
    
    [bigTitle setFont:[UIFont systemFontOfSize:17.0/360.0*ScreenWidth]];
    bigTitle.textColor=[UIColor colorWithHexString:@"#333333"];
    [bgView1 addSubview:bigTitle];
    
    UILabel *smallTitle=[[UILabel alloc]initWithFrame:CGRectMake(119.0/360.0*ScreenWidth, 43.0/667.0*ScreenHeight, 129.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    self.smallTitke=smallTitle;
    
    [smallTitle setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
    smallTitle.textColor=[UIColor colorWithHexString:@"#333333"];
    [bgView1 addSubview:smallTitle];
    
    
    UIButton *telephone=[[UIButton alloc]initWithFrame:CGRectMake(119.0/360.0*ScreenWidth, 65.0/667.0*ScreenHeight, ScreenWidth-119.0/360.0*ScreenWidth, 22.0/667.0*ScreenHeight)];
    [telephone addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView1 addSubview:telephone];
    
    
    UIImageView *smallImage=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, 1.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    
    smallImage.image=[UIImage imageNamed:@"nzg_phonenumber"];
    [telephone addSubview:smallImage];
    
    
    UILabel *numberLable=[[UILabel alloc]initWithFrame:CGRectMake(20.0/360.0*ScreenWidth, 1.0/667.0*ScreenHeight, 179.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    self.numberLable=numberLable;
   
    [numberLable setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
    numberLable.textColor=[UIColor colorWithHexString:@"#555555"];
    [telephone addSubview:numberLable];
    
//-----------地图相关View-----
    
    UIImageView *MapButtonView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0/360.0*ScreenWidth, 120.0/667.0*ScreenHeight, ScreenWidth, 70.0/667.0*ScreenHeight)];
    MapButtonView.userInteractionEnabled=YES;
    MapButtonView.backgroundColor=[UIColor whiteColor];
    [contentView addSubview:MapButtonView];
    
    UIButton *mapBt=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 70.0/667.0*ScreenHeight)];
    [mapBt addTarget:self action:@selector(mapViewAction) forControlEvents:UIControlEventTouchUpInside];
    [MapButtonView addSubview:mapBt];
    
    UIImageView *markImage=[[UIImageView alloc]initWithFrame:CGRectMake(20.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight, 30.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
    
    markImage.image=[UIImage imageNamed:
                     @"nzg_adress-1"];
    [mapBt addSubview:markImage];
    
    UILabel *dressLable=[[UILabel alloc]initWithFrame:CGRectMake(70.0/360.0*ScreenWidth, 29.0/667.0*ScreenHeight, ScreenWidth-100.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight)];
    self.adress=dressLable;
    
    [dressLable setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
    dressLable.textColor=[UIColor colorWithHexString:@"#333333"];
    [mapBt addSubview:dressLable];

#pragma mark - //右侧的箭头，暂时隐藏
    
    UIImageView *backImage=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-40.0/360.0*ScreenWidth, 25.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    backImage.image=[UIImage imageNamed:@"arrow"];
    [mapBt addSubview:backImage];
    
    
//-----农展馆下半部分；正在展出......-----
    _lineImage1= [[UIView alloc]initWithFrame:CGRectMake(85.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight, 1, 43.0/667.0*ScreenHeight)];
    _lineImage1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
    [self.view addSubview:_lineImage1];
    
    _lineImage2= [[UIView alloc]initWithFrame:CGRectMake(85.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+55.0/667.0*ScreenHeight, 1, 43.0/667.0*ScreenHeight)];
    _lineImage2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
    [self.view addSubview:_lineImage2];
    
    _lineImage3= [[UIView alloc]initWithFrame:CGRectMake(85.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+98.0/667.0*ScreenHeight, 1, 43.0/667.0*ScreenHeight)];
    _lineImage3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
    [self.view addSubview:_lineImage3];
    
    _lineImage4= [[UIView alloc]initWithFrame:CGRectMake(85.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+141.0/667.0*ScreenHeight, 1, ScreenHeight-(_lineImage3.frame.origin.y-43.0/667.0*ScreenHeight))];
    _lineImage4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
    
    [self.view addSubview:_lineImage4];
    
 
    
    _buttonName=@[@"正在展出",@"即将展出",@"历届展会"];
    
    _buttonColor=[[NSMutableArray alloc]init];
    for (int i=0; i<3; i++) {
       
    //---横线
        UIImageView *hengLineImage=[[UIImageView alloc]initWithFrame:CGRectMake(13.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+55.0/667.0*ScreenHeight+43.0/667.0*ScreenHeight*i, 72.0/360.0*ScreenWidth, 1)];
        hengLineImage.backgroundColor=[UIColor grayColor];
        hengLineImage.alpha=0.2;
        [self.view addSubview:hengLineImage];
    //---按钮
        UIButton *nzgButton=[[UIButton alloc]initWithFrame:CGRectMake(17.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight+43.0/667.0*ScreenHeight*i, 58.0/360.0*ScreenWidth, 43.0/667.0*ScreenHeight)];
        nzgButton.tag=1000+i;
        [nzgButton setTitle:_buttonName[i] forState:UIControlStateNormal];
        [nzgButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        
        [nzgButton.titleLabel setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
        [nzgButton addTarget:self action:@selector(nzgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonColor addObject:nzgButton];
        _lastBtn=1000;
       
        if (nzgButton.tag==1000) {
            nzgButton.selected=YES;
            _lineImage1.backgroundColor=[UIColor whiteColor];
            [nzgButton setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateNormal];
        }
        
        
        [self.view addSubview:nzgButton];
        
    }
    
    
}
#pragma mark - //刷新农展馆介绍
-(void)loadNewdetailData{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.buildInfo", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
       // NSLog(@"展馆详情请求成功,liebiaoxinxi＝＝JSON: %@", responseObject);
        
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"NZGdetail"];
        
        [self.contentView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

-(void)callAction{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"025-86263188"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
    NSLog(@"您要拨打电话");
    
}

-(void)mapViewAction{
    //CCBaseNavViewController *SecondController = [[CCBaseNavViewController alloc]initWithRootViewController:_secListWebViewController];
    //    [self presentViewController:SecondController animated:YES completion:nil];
    NSLog(@"您正在地图定位");
    CCMapViewController *mapViewCon=[[CCMapViewController alloc]init];
    mapViewCon.title=@"展馆导航";
    [self.navigationController pushViewController:mapViewCon animated:YES];
}

-(void)nzgButtonAction:(UIButton *)currentButton{
    //上次点击的
    UIButton *lastBtn =(UIButton *)[self.view viewWithTag:_lastBtn];
    [lastBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    //这次点击的
    [currentButton setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateNormal];
    //重新赋值
    _lastBtn=currentButton.tag;
    if (currentButton.tag==1000) {
        
        [_nowTableView removeFromSuperview];
        [_histroyTableView removeFromSuperview];
        if ([_scroller viewWithTag:2000]) {
            [_scroller removeFromSuperview];
        }else{
        }[self setNowExihibition];
        
 
        _lineImage1.backgroundColor = [UIColor whiteColor];
        _lineImage2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
        _lineImage3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
        _lineImage4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
        
    }
    if(currentButton.tag==1001){
        [self requestWillData];
        [_scroller removeFromSuperview];
        [_histroyTableView removeFromSuperview];
        if ([_nowTableView viewWithTag:2001]) {
            [_nowTableView removeFromSuperview];
        }else{
        }[self setWillView];
        
        _lineImage1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
        _lineImage2.backgroundColor=[UIColor whiteColor];
        _lineImage3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
        _lineImage4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
    }
    if (currentButton.tag==1002) {
        [self requestHistoryData];
        [_nowTableView removeFromSuperview];
        [_scroller removeFromSuperview];
        if ([_histroyTableView viewWithTag:2002]) {
            [_histroyTableView removeFromSuperview];
        }else{
        }[self setHistoryView];
        _lineImage1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
        _lineImage2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
        _lineImage3.backgroundColor = [UIColor whiteColor];
        _lineImage4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_line_shuxian"]];
        
    }
}

//＝－－－即将展出列表－－－－
-(void)setWillView{
    if (self.exihibition) {
         _nowTableView=[[UITableView alloc]initWithFrame:CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+22.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight)-130.0/667.0*ScreenHeight)];
    }else{
    _nowTableView=[[UITableView alloc]initWithFrame:CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+22.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-(ScreenHeight-305.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight))];
    }
    _nowTableView.separatorStyle = NO;
    _nowTableView.tag=2001;
    _nowTableView.delegate=self;
    _nowTableView.dataSource=self;
    [self.view addSubview:_nowTableView];
    
    _curPage = 1;
    
    
    _nowTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _nowTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_nowTableView.mj_header beginRefreshing];

}


//----下拉刷新-----
-(void)loadNewData{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.open", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        [self.willExihibitions removeAllObjects];
        self.willExihibitions = [CCWillExihibitionModel
                           mj_objectArrayWithKeyValuesArray:article];
        if (article==nil) {
            
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"很抱歉，暂无即将展出信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                [_nowTableView.mj_header endRefreshing];
                return;
                
            

        }
        [_nowTableView reloadData];
        
        
        _curPage = 2;
        [_nowTableView.mj_header endRefreshing];
        [_nowTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_nowTableView.mj_header endRefreshing];
        [_nowTableView.mj_footer endRefreshing];
    }];
}

//------上拉加载更多-----

- (void)loadMoreData {
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.open", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSArray *article = responseObject[@"article"];
        NSArray *dataArr = [CCWillExihibitionModel
                            mj_objectArrayWithKeyValuesArray:article];
        
        
        CCWillExihibitionModel *firstModel = [dataArr firstObject];
        CCWillExihibitionModel *lastModel = [self.willExihibitions lastObject];
        CCWillExihibitionModel *lastData = [dataArr lastObject];
        if ([firstModel.ids isEqualToString:lastModel.ids]|| [lastModel.ids isEqualToString:lastData.ids]) {
            [_nowTableView.mj_footer endRefreshingWithNoMoreData];
            
        } else {
           [_willExihibitions addObjectsFromArray:dataArr];
            [_nowTableView.mj_footer endRefreshing];
        }
        [_nowTableView.mj_header endRefreshing];
        [_nowTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_nowTableView.mj_header endRefreshing];
        [_nowTableView.mj_footer endRefreshing];
    }];
}


//################展出历史列表###################################################
-(void)setHistoryView{
    if (self.exihibition) {
        _histroyTableView=[[UITableView alloc]initWithFrame:CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+22.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight)-130.0/667.0*ScreenHeight)];
    }else{
    _histroyTableView=[[UITableView alloc]initWithFrame:CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+22.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-(ScreenHeight-305.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight))];
    }
    _histroyTableView.separatorStyle = NO;
    _histroyTableView.tag=2002;
    _histroyTableView.delegate=self;
    _histroyTableView.dataSource=self;
    [self.view addSubview:_histroyTableView];
    _curPage = 1;
    
    
    _histroyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData2)];
    _histroyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData2)];
    
    [_histroyTableView.mj_header beginRefreshing];

}
//----下拉刷新-----
-(void)loadNewData2{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.previous", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
        [self.historyExibitions removeAllObjects];
        self.historyExibitions = [CCHistoryExihibitionModel
                                 mj_objectArrayWithKeyValuesArray:article];
        if (article==nil) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"很抱歉，暂无展会信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [_histroyTableView.mj_header endRefreshing];
            return;
            
            
            
        }

        [_histroyTableView reloadData];
        
        
        _curPage = 2;
        [_histroyTableView.mj_header endRefreshing];
        [_histroyTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_histroyTableView.mj_header endRefreshing];
        [_histroyTableView.mj_footer endRefreshing];
    }];
}

//------上拉加载更多-----

- (void)loadMoreData2 {
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.exhibition.previous", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSArray *article = responseObject[@"article"];
        NSArray *dataArr = [CCHistoryExihibitionModel
                            mj_objectArrayWithKeyValuesArray:article];
       
        
        CCHistoryExihibitionModel *firstModel = [dataArr firstObject];
        CCHistoryExihibitionModel *lastModel = [self.historyExibitions lastObject];
        CCHistoryExihibitionModel *lastData = [dataArr lastObject];
        if ([firstModel.ids isEqualToString:lastModel.ids]|| [lastModel.ids isEqualToString:lastData.ids]) {
            [_histroyTableView.mj_footer endRefreshingWithNoMoreData];
          
        } else {
            [_historyExibitions addObjectsFromArray:dataArr];
            [_histroyTableView.mj_footer endRefreshing];
        }
        [_histroyTableView.mj_header endRefreshing];
        [_histroyTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_histroyTableView.mj_header endRefreshing];
        [_histroyTableView.mj_footer endRefreshing];
    }];
}



- (void)addButton {
    
    UIButton *sort = [[UIButton alloc ]initWithFrame:CGRectMake(0.0, 245.0/667.0*ScreenHeight, ScreenWidth / 2.0-1.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight)];
    sort.tag=1001;
    [sort setTitle:@"展馆动态" forState:UIControlStateNormal];
    [sort addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //======设置button的两种状态
    sort.selected=YES;
    _Abutton=sort;
    [sort setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sort setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateSelected];
    
    _bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(25.0/360.0*ScreenWidth, 8.0/667.0*ScreenHeight, 22.0/360.0*ScreenWidth, 22.0/667.0*ScreenHeight)];
    _bgImage.image=[UIImage imageNamed:@"nzg_richeng_pre"];
    [sort addSubview:_bgImage];
    
    sort.titleLabel.font = [UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    
    
    [self.view addSubview:sort];
    
    
    //------展馆介绍－－－－
    UIButton *recommend =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth / 2.0+1.0/360.0*ScreenWidth, 245.0/667.0*ScreenHeight, ScreenWidth / 2.0, 40.0/667.0*ScreenHeight)];
    recommend.tag=1002;
    [recommend setTitle:@"展馆介绍" forState:UIControlStateNormal];
    
    [recommend addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _tjImage=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth / 2.0+25.0/360.0*ScreenWidth, 8.0/667.0*ScreenHeight, 22.0/360.0*ScreenWidth, 22.0/667.0*ScreenHeight)];
    _tjImage.image=[UIImage imageNamed:@"nzg_jieshao_nor"];
    [recommend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [recommend setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateSelected];
    recommend.titleLabel.font = [UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    
    
    [sort addSubview:_tjImage];
    [self.view addSubview:recommend];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth / 2.0, 256.0/667.0*ScreenHeight, 1.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.2;
    [self.view addSubview:line];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(13.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+12.0/667.0*ScreenHeight, ScreenWidth-26.0/360.0*ScreenWidth, 1.0/667.0*ScreenHeight)];
    line2.backgroundColor = [UIColor grayColor];
    line2.alpha = 0.2;
    [self.view addSubview:line2];
    
    
    
}

-(void)sortAction:(UIButton*)button{
    _Abutton.selected=NO;
    button.selected=YES;
    [UIView animateWithDuration:0.3 animations:^{
        
        _bgImage.image=[UIImage imageNamed:@"nzg_richeng_nor"];        if (button.tag==1001&&button.selected==YES) {
        _bgImage.image=[UIImage imageNamed:@"nzg_richeng_pre"];
            
            
        }
        _tjImage.image=[UIImage imageNamed:@"nzg_jieshao_nor"];
        if (button.tag==1001&&button.selected==YES) {
            [_nzgjieshao removeFromSuperview];
        }
        if (button.tag==1002&&button.selected==YES) {
            if ([_nzgjieshao viewWithTag:2003]) {
                [_nzgjieshao removeFromSuperview];
            }else{
            }[self setNzg];
            
            _tjImage.image=[UIImage imageNamed:@"nzg_jieshao_pre"];
        }
    }];
    
    _Abutton=button;
    
    
}

-(void)setNzg{
    _nzgjieshao=[[UIScrollView alloc]initWithFrame:CGRectMake( 0.0, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+13.0/667.0*ScreenHeight, ScreenWidth, ScreenHeight-(ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+16.0/667.0*ScreenHeight))];
    _nzgjieshao.tag=2003;
    _nzgjieshao.contentSize=CGSizeMake(ScreenWidth-10, ScreenHeight-300/667.0*ScreenHeight);
    _nzgjieshao.scrollEnabled=YES;
    //_nzgjieshao.userInteractionEnabled=YES;
    _nzgjieshao.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_nzgjieshao];
    UILabel *detailLable=[[UILabel alloc]initWithFrame:CGRectMake(20.0/360.0*ScreenWidth, 0.0, 325.0/360.0*ScreenWidth, 230.0/667.0*ScreenHeight)];
    self.descripitions=detailLable;
    self.descripitions.text=[NSString stringWithFormat:@"      %@",_buildDesc];
    
    detailLable.numberOfLines=0;
    detailLable.userInteractionEnabled=YES;
    [detailLable setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
    detailLable.textColor=[UIColor colorWithHexString:@"#3f3f3f"];
    detailLable.textAlignment=NSTextAlignmentJustified;
    [_nzgjieshao addSubview:detailLable];

}





//-----tableView代理部分－－－

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_exihibitioning]) {
        _nowModel=self.exihibitionings[indexPath.row];
        _exihibitioning.userInteractionEnabled=NO;
        [self requestExihitioningData2];
    }
    
    if ([tableView isEqual:_histroyTableView]) {
        _historyModel=self.historyExibitions[indexPath.row];
        _histroyTableView.userInteractionEnabled=NO;
        [self requestHistoryData2];
    }
    if ([tableView isEqual:_nowTableView]) {
        _willModel=self.willExihibitions[indexPath.row];
        _nowTableView.userInteractionEnabled=NO;
        [self requestWillData2];
        
        
    }
    
    
}
-(void)requestExihitioningData2{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    NSString *urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_nowModel.ids,ids];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:urlString parameters:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             //NSLog(@"即将展出详情请求成功＝＝JSON: %@", responseObject);
             _secListmodel=[[CCSecListModel  alloc]init];
             _secListmodel=[CCSecListModel mj_objectWithKeyValues:responseObject];
             //NSLog(@"即将展出模型内容是＝＝＝＝%@",_secListmodel);
             [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
             [self setController3:responseObject];
             
         
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

}
-(void)setController3:(id)responseObject{
    
    _secListWebViewController = [[CCSecListWebViewController alloc] init];
    _secListWebViewController.title=@"展会信息";
    _secListWebViewController.url=_nowModel.ids;
    _secListWebViewController.model=_secListmodel;
    
   
    
    [self.navigationController pushViewController:_secListWebViewController animated:YES];
    
    
    
}

-(void)requestWillData2{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    NSString *urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_willModel.ids,ids];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"即将展出详情请求成功＝＝JSON: %@", responseObject);
        _secListmodel=[[CCSecListModel  alloc]init];
        _secListmodel=[CCSecListModel mj_objectWithKeyValues:responseObject];
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setController2:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}

-(void)setController2:(id)responseObject{
    
    _secListWebViewController = [[CCSecListWebViewController alloc] init];
    _secListWebViewController.title=@"展会信息";
    _secListWebViewController.url=_willModel.ids;
    _secListWebViewController.model=_secListmodel;
    
    
    
    [self.navigationController pushViewController:_secListWebViewController animated:YES];
    
    
    
}

-(void)requestHistoryData2{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    NSString *urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_historyModel.ids,ids];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"即将展出详情请求成功＝＝JSON: %@", responseObject);
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
    _secListWebViewController.title=@"展会信息";
    _secListWebViewController.url=_historyModel.ids;
    _secListWebViewController.model=_secListmodel;
    

    
    [self.navigationController pushViewController:_secListWebViewController animated:YES];
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0/667.0*ScreenHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_exihibitioning]) {
        
        return self.exihibitionings.count;
       
    }
    if ([tableView isEqual:_histroyTableView]) {
        return self.historyExibitions.count;
        
          }
    if ([tableView isEqual:_nowTableView]) {
        return self.willExihibitions.count;
        
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_exihibitioning]) {
        
        static NSString *id=@"CCExihibitioningTableViewCell";
        _exihiCell=[tableView dequeueReusableCellWithIdentifier:id];
        if (_exihiCell==nil) {
            
            _exihiCell=[[CCExihibitioningTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
            
        }_exihiCell.model=self.exihibitionings[indexPath.row];
        _exihiCell.selectedBackgroundView = [[UIView alloc] initWithFrame:_exihiCell.frame];
        _exihiCell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
        
        //--------------赋名字---
        return _exihiCell;
    }
    if ([tableView isEqual:_histroyTableView]) {
        
        static NSString *id=@"CCHistroyTableViewCell";
        _hidtroyCell=[tableView dequeueReusableCellWithIdentifier:id];
        if (_hidtroyCell==nil) {
            
            _hidtroyCell=[[CCHistroyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
            
        }_hidtroyCell.model=self.historyExibitions[indexPath.row];
        _hidtroyCell.selectedBackgroundView = [[UIView alloc] initWithFrame:_hidtroyCell.frame];
        _hidtroyCell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
        
        //--------------赋名字---
       return _hidtroyCell;
    }
    if ([tableView isEqual:_nowTableView]) {
        
        static NSString *id2=@"CCNowTableViewCell";
        _nowCell=[tableView dequeueReusableCellWithIdentifier:id2];
        if (_nowCell==nil) {
            
            _nowCell=[[CCNowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id2];
            
        }_nowCell.model=self.willExihibitions[indexPath.row];
        _nowCell.selectedBackgroundView = [[UIView alloc] initWithFrame:_nowCell.frame];
        _nowCell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
        
        //--------------赋名字---
        return _nowCell;
    }
    
    return nil;
    
        

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"NZGdetail"];
    NSString *address=[dics objectForKey:@"address"];
    _buildDesc=[dics objectForKey:@"buildDesc"];
    NSString *name=[dics objectForKey:@"name"];
    NSString *phone=[dics objectForKey:@"phone"];
    NSString *title=[dics objectForKey:@"title"];
    NSString *photo=[dics objectForKey:@"photo"];
    self.bigTitle.text=name;
    self.smallTitke.text=title;
    self.numberLable.text=phone;
    self.adress.text=address;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
    if (self.exihibition) {
        
        
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
        mylable.text=@"农展馆";
        mylable.textColor=[UIColor whiteColor];
        [_redview addSubview:mylable];
        [window addSubview:_redview];
        
    }
     _exihibitioning.userInteractionEnabled=YES;
    _histroyTableView.userInteractionEnabled=YES;
    _nowTableView.userInteractionEnabled=YES;
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
