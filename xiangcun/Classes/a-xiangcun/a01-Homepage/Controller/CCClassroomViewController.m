//
//  CCClassroomViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCClassroomViewController.h"
#import <SDCycleScrollView.h>
#import "CCClassroomItemCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCClassCollectionViewCell.h"
#import "CCClassroomItemModel.h"
#import "CCPlantTableViewCell.h"
#import "CCClassCollectionView.h"
#import "CCBaseNavViewController.h"
#import "CCAdDetailViewController.h"
#import "CCCommendCell.h"
#import "CCInformationModel.h"
#import "MJRefresh.h"
#import "CCWebViewController.h"
#import "CCPlantMoreViewController.h"


static NSString *commend=@"CCCommendCell";
static NSString *classCell=@"CCClassCollectionViewCell";
@interface CCClassroomViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate>
{
    UIView *_redview;
    CCWebViewController *_webViewController;
    NSMutableArray *_imageUrls;
    NSMutableArray *_imageNames;
    UITableView *_plantTableview;
    CCClassCollectionView *_referrerTableview;
    NSArray *_titles;
    CCPlantTableViewCell *_plantCell;
    int _collectionIndex;
    int _tablerIndex;
    UIView *_nowView;
    UIButton *_aButton;
    CCCommendCell *_cell;//－大课堂推荐里面的collectioncell
    NSArray *_titless;
    CCClassCollectionViewCell *_cell1;//－大课堂更多视频下方的collectioncell
    UIScrollView *_adScrollView;//下拉刷新广告
    CCAdDetailViewController *_adDetailView;
    NSString *_urlString;
    NSString *_urlString2;
    UICollectionView *_informationList;
    UICollectionView *_itemList;
    NSString *_methodStr;
    NSIndexPath *_selectedIndexPath;
    SDCycleScrollView *_cycleScrollView;
    int _which;
    UIButton *_sorts;
    UIButton *_recommends;
}
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *collectionDatas;
@property (nonatomic,strong)NSMutableArray *datasModel;
@property (nonatomic,strong)NSMutableArray *fenleiData;
@property (nonatomic,strong)NSMutableArray *rightCollectionData;
@property (nonatomic,assign) NSInteger curPage;
@property (nonatomic, strong) NSMutableArray *advDatasArr;

@end

@implementation CCClassroomViewController

- (NSMutableArray *)advDatasArr {
    
    if (!_advDatasArr) {
        _advDatasArr = [NSMutableArray array];
    }
    return _advDatasArr;
}

- (NSMutableArray *)collectionDatas {
    
    if (!_collectionDatas) {
        
        _collectionDatas = [NSMutableArray array];
    }
    
    return _collectionDatas;
}
- (NSMutableArray *)datasModel {
    
    if (!_datasModel) {
        
        _datasModel = [NSMutableArray array];
    }
    
    return _datasModel;
    
}
- (NSMutableArray *)fenleiData {
    
    if (!_fenleiData) {
        
        _fenleiData = [NSMutableArray array];
    }
    
    return _fenleiData;
}
- (NSMutableArray *)rightCollectionData {
    
    if (!_rightCollectionData) {
        
        _rightCollectionData = [NSMutableArray array];
    }
    
    return _rightCollectionData;
}

- (void)viewDidLoad {
    
    if (self.miroFilm) {
         _adScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth ,45.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, ScreenHeight)];
    }else{
    _adScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth ,94.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, ScreenHeight)];
    }
    
    _adScrollView.userInteractionEnabled=YES;
    _which=2;
    [self requestCommendlist];
    [self requsetData];
    [self addCollectionView];
    [self addFenlan];
    
    
//    [self setupPlantTableview];
    
//    [_referrerTableview reloadData];
    _adScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCommendNewData2)];
    
    
    [_adScrollView.mj_header beginRefreshing];
    
    
    [self.view addSubview:_adScrollView];

   
}
#pragma mark --分类推荐，按钮视图创建
- (void)addFenlan {
    _sorts = [UIButton buttonWithType:UIButtonTypeCustom];
    _sorts.frame = CGRectMake(0.0, 260.0/667.0*ScreenHeight, ScreenWidth / 2.0, 30.0/667.0*ScreenHeight);
    [_sorts setTitle:@"分类" forState:UIControlStateNormal];
    [_sorts setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sorts setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateSelected];
    _sorts.titleLabel.font = [UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    [_sorts addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _sorts.tag=1001;
    
    
    [_adScrollView addSubview:_sorts];
    
    _recommends = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommends.frame = CGRectMake(ScreenWidth / 2.0, 260.0/667.0*ScreenHeight, ScreenWidth / 2.0, 30/667.0*ScreenHeight);
    _recommends.tag=1002;
    _recommends.selected=YES;
    _aButton=_recommends;
    [_recommends setTitle:@"推荐" forState:UIControlStateNormal];
    [_recommends setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_recommends setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateSelected];
    _recommends.titleLabel.font = [UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    [_recommends addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_adScrollView addSubview:_recommends];
   
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth / 2.0, 255.0/360.0*ScreenWidth, 1.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.2;
    [_adScrollView addSubview:line];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0.0/360.0*ScreenWidth, 291.0/667.0*ScreenHeight, ScreenWidth, 1.0/667.0*ScreenHeight)];
    line2.backgroundColor = [UIColor grayColor];
    line2.alpha = 0.2;
    [_adScrollView addSubview:line2];
    
    UIButton *moreLable=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-91.0/360.0*ScreenWidth,303.0/667.0*ScreenHeight, 64.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight)];
    [moreLable setTitle:@"更多视频" forState:UIControlStateNormal];
    [moreLable setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateNormal];
    [moreLable addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    moreLable.titleLabel.font=[UIFont systemFontOfSize:14.0/360.0*ScreenWidth];
    [_adScrollView addSubview:moreLable];
    
    UIImageView *morImg=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-91.0/360.0*ScreenWidth)+64.0/360.0*ScreenWidth, 300.0/667.0*ScreenHeight , 15.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    morImg.image=[UIImage imageNamed:@"btn_more"];
    [_adScrollView addSubview:morImg];

}
#pragma mark --更多视频，按钮点击事件
-(void)moreAction{
    
    CCPlantMoreViewController *plant=[[CCPlantMoreViewController alloc]init];
    plant.name=_fenleiModel.name;
    plant.ids=_fenleiModel.ids;
    [self.navigationController pushViewController:plant animated:YES];
    
    
 
}

#pragma mark --分类推荐，按钮点击事件
- (void)handleButtonAction:(UIButton *)currentBtn {
    _aButton.selected=NO;
    currentBtn.selected=YES;
    if (currentBtn.tag==1001&&currentBtn.selected==YES) {
        _which=1;
        if ([_nowView viewWithTag:2003]) {
            [_nowView removeFromSuperview];
        }
        NSLog(@"_nowViewframe333==%@",NSStringFromCGRect(_nowView.frame));
        [self requestFenLeiData1];
        
    }if (currentBtn.tag==1002&&currentBtn.selected==YES){
        _which=2;
//        [_plantTableview removeFromSuperview];
        [self requestCommendlist];
        if ([_nowView viewWithTag:2003]) {
            [_nowView removeFromSuperview];
        }else{
            
        }
        
    }
    
        
            _aButton=currentBtn;
    
}
#pragma mark --推荐
-(void)setNowView{
    
   
    _nowView=[[UIView alloc]init];
_nowView.frame=CGRectMake( 2.0/360.0*ScreenWidth, 300.0/667.0*ScreenHeight, ScreenWidth-4.0/360.0*ScreenWidth, ((_collectionDatas.count/2)+1)*((ScreenWidth - 50.0/360.0*ScreenWidth)/2));
    _nowView.tag=2003;
    
    _nowView.backgroundColor=[UIColor whiteColor];
    [_adScrollView addSubview:_nowView];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 3.0/360.0*ScreenWidth;
//    layout.minimumInteritemSpacing=10;
    
    
    layout.itemSize = CGSizeMake((ScreenWidth - 40.0/360.0*ScreenWidth/360.0*ScreenWidth)/2, (ScreenWidth - 30.0/360.0*ScreenWidth/360.0*ScreenWidth)/2);                     //260
    _informationList = [[UICollectionView alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 0.0, ScreenWidth-20.0/360.0*ScreenWidth, ((_datasModel.count/2)+1)*((ScreenWidth - 30.0/360.0*ScreenWidth)/2)) collectionViewLayout:layout];//370
        _informationList.tag=2003;
    _informationList.scrollEnabled=NO;
    _informationList.backgroundColor = [UIColor whiteColor];
    [_informationList registerClass:[CCCommendCell class] forCellWithReuseIdentifier:@"commend"];
    
    _informationList.delegate = self;
    _informationList.dataSource = self;
    _informationList.showsVerticalScrollIndicator = NO;
    _informationList.showsHorizontalScrollIndicator = NO;
    [_nowView addSubview:_informationList];
    _curPage = 1;
    
    
//    _informationList.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCommendNewData)];
   
    
//    [_informationList.mj_header beginRefreshing];
}
//----下拉刷新-----
//-(void)loadCommendNewData{
//   
//}





//---首次请求推荐内容
-(void)requestCommendlist{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.index.institutions", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *article = responseObject[@"article"];
       
        self.collectionDatas = [CCInformationModel
                           mj_objectArrayWithKeyValuesArray:article];
        if (self.miroFilm) {
            _adScrollView.contentSize=CGSizeMake(ScreenWidth - 10.0/360.0*ScreenWidth, ((375.0/667.0*ScreenHeight)+((_collectionDatas.count/2)+1)*(ScreenWidth - 30)/2));
        }else{
        _adScrollView.contentSize=CGSizeMake(ScreenWidth - 10.0/360.0*ScreenWidth, ((300.0/667.0*ScreenHeight)+((_collectionDatas.count/2)+1)*(ScreenWidth - 30)/2));
        }
        [self setNowView];
        [_informationList reloadData];
       
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
       
    }];
    
}

    
    


#pragma mark--分类
- (void)addCollectionView {
    NSArray *titles = @[@"种植",@"养殖",@"园艺",@"水产",@"其他"];
   
    for (NSUInteger i = 0; i <5; i++ ) {
        CCClassroomItemModel *model = [[CCClassroomItemModel alloc]init];
        model.titleString = titles[i];
        model.itemImage = [NSString stringWithFormat:@"item%ld",(unsigned long)i];
        [self.items addObject:model];
    }
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 5.0/360.0*ScreenWidth;
    layout.minimumInteritemSpacing=10.0/360.0*ScreenWidth;
    
    layout.itemSize = CGSizeMake((ScreenWidth -40.0/360.0*ScreenWidth) / 5 , 62.0/667.0*ScreenHeight);
   _itemList = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0, 187.0/667.0*ScreenHeight, ScreenWidth, 62.0/667.0*ScreenHeight) collectionViewLayout:layout];
       
    [_adScrollView addSubview:_itemList];
    _itemList.backgroundColor = [UIColor clearColor];
    [_itemList registerClass:[CCClassroomItemCell class] forCellWithReuseIdentifier:@"itemCell"];
    _itemList.delegate = self;
    _itemList.dataSource = self;
    _itemList.showsVerticalScrollIndicator = NO;
    _itemList.showsHorizontalScrollIndicator = YES;
    [_adScrollView addSubview:_itemList];

}


//------collectionView代理部分
#pragma mark --collectionViewDelegate(推荐和大的分类)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:_informationList]) {
        return self.collectionDatas.count;
        
    }
    if ([collectionView isEqual:_itemList]) {
         return self.items.count;
        
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:_informationList]) {
        _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"commend" forIndexPath:indexPath];
        
   
    _cell.infomationModel =self.collectionDatas[indexPath.item];
    return _cell;
    }
    if ([collectionView isEqual:_itemList]) {
        CCClassroomItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
        CCClassroomItemModel *model = self.items[indexPath.row];
        cell.model = model;
        return cell;

        
    }
    return nil;
}

//----请求分类数据collectionView点击事件－－

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([collectionView isEqual:_informationList]) {
        self.view.userInteractionEnabled=NO;
        self.inforModel=self.collectionDatas[indexPath.item];
        
        [self requestCommendDetail];
    }else if([collectionView isEqual:_itemList]){
        _which=1;
       
        if (indexPath.row==4) {
            CCPlantMoreViewController *plant=[[CCPlantMoreViewController alloc]init];
            plant.name=@"其他";
            plant.ids=@"72";
            [self.navigationController pushViewController:plant animated:YES];
           
        }else{
            NSLog(@"_nowViewframe==%@",NSStringFromCGRect(_nowView.frame));
            _recommends.selected=NO;
            _sorts.selected=YES;
            _aButton=_sorts;
            _collectionIndex=(int)indexPath.item;
            
            [_nowView removeFromSuperview];
//            [self setupPlantTableview];
//            [_plantTableview removeFromSuperview];
//            [_referrerTableview removeFromSuperview];
            NSArray*method=@[@"institutions.category.plant",@"institutions.category.breed",@"institutions.category.gradener",@"institutions.category.aquatic",@"institutions.category.other"];
            _methodStr=method[indexPath.item];
//       [self requestFenLeiData1];
        [self requestFenLeiData2];
        
        
        

        
       
        
    [collectionView deselectItemAtIndexPath:indexPath animated:YES] ;
        }
    }
}
#pragma mark --分类tableview首次展示时请求数据
-(void)requestFenLeiData1{
         _urlString=[NSString stringWithFormat:@"%@?method=institutions.category.plant&appKey=w4q897jgvxkb&v=1.0&format=json",KURL];
    if ([_nowView viewWithTag:2003]) {
        [_nowView removeFromSuperview];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        [_plantTableview removeFromSuperview];
        NSArray *category = responseObject[@"category"];
       
        self.fenleiData = [CCClassroomModel
                           mj_objectArrayWithKeyValuesArray:category];
       
        _fenleiModel=self.fenleiData[0];
       [self setupPlantTableview];
        [_plantTableview reloadData];
        
        [self requestRightCollectionData];
        [_referrerTableview reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}
-(void)requestFenLeiData2{
    _urlString=[NSString stringWithFormat:@"%@?method=%@&appKey=w4q897jgvxkb&v=1.0&format=json",KURL,_methodStr];
    [_nowView removeFromSuperview];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
//        [_referrerTableview removeFromSuperview];
        NSArray *category = responseObject[@"category"];
        
        self.fenleiData = [CCClassroomModel
                           mj_objectArrayWithKeyValuesArray:category];
        [self setupPlantTableview];
        _fenleiModel=self.fenleiData[0];
        
        [_plantTableview reloadData];
        [self requestRightCollectionData];
//        [_referrerTableview reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}

#pragma mark --分类列表数据请求
-(void)requestFenLeiData{
    
    _urlString=[NSString stringWithFormat:@"%@?method=%@&appKey=w4q897jgvxkb&v=1.0&format=json",KURL,_methodStr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
               NSArray *category = responseObject[@"category"];
       
        self.fenleiData = [CCClassroomModel
                           mj_objectArrayWithKeyValuesArray:category];
       
        [_plantTableview reloadData];
       
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
    
}


//--------请求推荐里面的详情------
-(void)requestCommendDetail{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    _urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_inforModel.ids,ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
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
    _webViewController.title=@"大课堂推荐";
    _webViewController.model=self.detailModel;
 
    [self.navigationController pushViewController:_webViewController animated:YES];
    
    
}



//----轮播点击方法
#pragma mark --SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    self.clssModel=self.advDatasArr[index];
//NSLog(@"---点击了第%ld张图片", (long)index);
    self.view.userInteractionEnabled=NO;
    [self requestAdDetailData];
    self.adDetailModel=self.advDatasArr[index];
}


//-----滑动广告请求数据－－
-(void)requsetData{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=ad.query.institutions&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        // NSLog(@"请求成功＝＝JSON: %@", responseObject);
        
        NSArray *ad = responseObject[@"ad"];
        
        self.advDatasArr = [CCAdddModel
                           mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_clssModel in self.advDatasArr) {
            
            
            [_imageUrls addObject:_clssModel.adImage];
            [_imageNames addObject:_clssModel.adName];
        }
    
        [self ScrollNetWorkImages];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
 
    
}

-(void)ScrollNetWorkImages{
    
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0.0/360.0*ScreenWidth ,0.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, 170.0/667.0*ScreenHeight) delegate:self placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
    _cycleScrollView.autoScrollTimeInterval=4;
    if ([_clssModel.video isEqualToString:@""]) {
        
    }else{
        UIImageView *adPlayImage=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-30.0/360.0*ScreenWidth)/2, (170.0/667.0*ScreenHeight-30.0/667.0*ScreenHeight)/2, 30.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
        adPlayImage.image=[UIImage imageNamed:@"banner_bofang"];
        [_cycleScrollView addSubview:adPlayImage];
    }
    
  
    

    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.titlesGroup = _imageNames;
   
    _cycleScrollView.currentPageDotColor = AppMainColor; // 自定义分页控件小圆标颜色
    _cycleScrollView.imageURLStringsGroup = _imageUrls;
    [_adScrollView addSubview:_cycleScrollView];
      
    
}
-(void)loadCommendNewData2{
    NSURL *URL2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=ad.query.institutions&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    manager2.responseSerializer =[AFJSONResponseSerializer serializer];
    manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager2 GET:URL2.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        // NSLog(@"请求成功＝＝JSON: %@", responseObject);
        
        NSArray *ad = responseObject[@"ad"];
        [_cycleScrollView removeAllSubviews];
        self.advDatasArr = [CCAdddModel
                            mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_clssModel in self.advDatasArr) {
            
            
            [_imageUrls addObject:_clssModel.adImage];
            [_imageNames addObject:_clssModel.adName];
        }
        
        [self ScrollNetWorkImages];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=ad.query.institutions&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        // NSLog(@"请求成功＝＝JSON: %@", responseObject);
        
        NSArray *ad = responseObject[@"ad"];
        
        self.advDatasArr = [CCAdddModel
                            mj_objectArrayWithKeyValuesArray:ad];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_clssModel in self.advDatasArr) {
            // NSLog(@"%@,%@",_model.adImage,_model.adName);
            
            [_imageUrls addObject:_clssModel.adImage];
            [_imageNames addObject:_clssModel.adName];
        }

        _curPage = 2;
        [_adScrollView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_adScrollView.mj_header endRefreshing];
        
    }];
    if (_which==2) {
        NSURL *URLs = [NSURL URLWithString:KURL];
        AFHTTPSessionManager *managers= [AFHTTPSessionManager manager];
        managers.requestSerializer = [AFJSONRequestSerializer serializer];
        managers.responseSerializer =[AFJSONResponseSerializer serializer];
        managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
        NSMutableDictionary *parameterss = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"article.index.institutions", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
        [managers GET:URLs.absoluteString parameters:parameterss success:^(NSURLSessionTask *task, id responseObject) {
            NSArray *article = responseObject[@"article"];
            self.datasModel = [CCInformationModel
                               mj_objectArrayWithKeyValuesArray:article];
            [_nowView removeFromSuperview];
            [self setNowView];
            [_informationList reloadData];
            //        _curPage = 2;
            [_informationList.mj_header endRefreshing];
            [_informationList.mj_footer endRefreshing];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [_informationList.mj_header endRefreshing];
            [_informationList.mj_footer endRefreshing];
        }];
    }else{
        
    }
    
}


//----------广告详情页网络请求-------
-(void)requestAdDetailData{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    _urlString2=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_clssModel.associateId,ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString2 parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
       
        self.adDetailModel=[[CCAdDetailModel alloc]init];
        self.adDetailModel=[CCAdDetailModel mj_objectWithKeyValues:responseObject];
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setAdController:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}
-(void)setAdController:(id)responseObject{
    
    _adDetailView = [[CCAdDetailViewController alloc] init];
    _adDetailView.url=_clssModel.associateId;
    _adDetailView.model=self.adDetailModel;
    
     _adDetailView.title=@"大课堂";

    [self.navigationController pushViewController:_adDetailView animated:YES];
    
    
    
    
    
}


- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
#pragma mark--某一种的分类tableview
-(void)setupPlantTableview{
    
   [_plantTableview removeFromSuperview];
    
    _plantTableview=[[UITableView alloc]initWithFrame:CGRectMake(0.0/360.0*ScreenWidth, 291.5/667.0*ScreenHeight, 125.0/360.0*ScreenWidth, (_fenleiData.count*42.0/667.0*ScreenHeight))];
    _plantTableview.delegate=self;
   
    _plantTableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _plantTableview.dataSource=self;
    _plantTableview.showsVerticalScrollIndicator = NO;
    
//    [self fristShowreferrerTableview];
    
    [_adScrollView addSubview:_plantTableview];
    
}
#pragma mark--创建 大分类的小分类的右侧 colltionview

-(void)fristShowreferrerTableview{
//   [self requestRightCollectionData];
//    NSLog(@"_rightCollectionData.count===%ld",_rightCollectionData.count);
    if (self.miroFilm) {
         _adScrollView.contentSize=CGSizeMake(ScreenWidth - 10.0/360.0*ScreenWidth, ((375.0/667.0*ScreenHeight)+((_rightCollectionData.count/2)+1)*(140.0/667.0*ScreenHeight)));
    }else{
        _adScrollView.contentSize=CGSizeMake(ScreenWidth - 10.0/360.0*ScreenWidth, ((300.0/667.0*ScreenHeight)+((_rightCollectionData.count/2)+1)*(140.0/667.0*ScreenHeight)));
    }
    [_referrerTableview removeFromSuperview];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing =5;
    
    layout.itemSize = CGSizeMake((ScreenWidth - 160.0/360.0*ScreenWidth)/2, 140.0/667.0*ScreenHeight);                     //260
    _referrerTableview = [[CCClassCollectionView alloc]initWithFrame:CGRectMake(130.0/360.0*ScreenWidth, 325.0/667.0*ScreenHeight, (ScreenWidth-145.0/360.0*ScreenWidth), ((_rightCollectionData.count/2)+1)*(140.0/667.0*ScreenHeight)) collectionViewLayout:layout];//370
    _referrerTableview.scrollEnabled=NO;
    _referrerTableview.nav=self.navigationController;
    [_referrerTableview registerClass:[CCClassCollectionViewCell class] forCellWithReuseIdentifier:@"classCell"];
    _referrerTableview.backgroundColor = [UIColor whiteColor];
    _referrerTableview.showsVerticalScrollIndicator = NO;
    _referrerTableview.showsHorizontalScrollIndicator = NO;
    [_adScrollView addSubview:_referrerTableview];


}

#pragma mark - UITableViewDataSource大类中的小类

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return self.fenleiData.count;
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_plantTableview]) {
       
        static NSString *id=@"CCPlantTableViewCell";
        _plantCell=[tableView dequeueReusableCellWithIdentifier:id];
        
        
        if (_plantCell==nil) {
            
            _plantCell=[[CCPlantTableViewCell alloc]init];
            
        }
        _plantCell.selectedBackgroundView = [[UIView alloc] initWithFrame:_plantCell.frame];
        _plantCell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        
//--------------赋名字---
        
            _plantCell.classModel=self.fenleiData[indexPath.row];
        
     
    }NSInteger selectedIndex = 0;
    _selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [_plantTableview selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    return _plantCell;
}
#pragma mark--UITableViewDelegate 点击大类中的小类
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    _fenleiModel=self.fenleiData[indexPath.row];
    _tablerIndex=(int)indexPath.row;
    [self requestRightCollectionData];
   
}

-(void)requestRightCollectionData{
    [_nowView removeFromSuperview];
    _urlString=[NSString stringWithFormat:@"%@?method=institutions.category.promote&appKey=w4q897jgvxkb&v=1.0&format=json&categoryId=%@",KURL,_fenleiModel.ids];
//NSLog(@"_fenleiModel.ids%@",_fenleiModel.ids);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//       NSLog(@"请求分类数据＝＝JSON: %@", responseObject);
        [_referrerTableview removeFromSuperview];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [self fristShowreferrerTableview];
            _referrerTableview.rightData=self.rightCollectionData;

             [_referrerTableview reloadData];
        });

        NSArray *article = responseObject[@"article"];

        self.rightCollectionData = [CCInformationModel
                           mj_objectArrayWithKeyValuesArray:article];
        
//       NSLog(@"_referrerTableview.rightData＝＝JSON: %@", _referrerTableview.rightData);
        
       
    } failure:^(NSURLSessionTask *operation, NSError *error) {

        
    }];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 42.0/667.0*ScreenHeight;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.userInteractionEnabled=YES;
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
        mylable.text=@"大课堂";
        mylable.textColor=[UIColor whiteColor];
        [_redview addSubview:mylable];
        [window addSubview:_redview];
        
    }
    
}
-(void)back{
    [_redview removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated {
   
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [_redview removeFromSuperview];
}
@end
