//
//  CCFarmTourViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCFarmTourViewController.h"
#import <SDCycleScrollView.h>
#import "CCFarmTourTableView.h"
#import "CCComendTableView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCSareaTableViewCell.h"
#import "CCAdDetailViewController.h"
#import "CCBaseNavViewController.h"
#import "MJRefresh.h"
#import "CCTourTableViewCell.h"
#import "CCJingDianSearch .h"
#import "CCCommendSearch .h"


static NSString *tourTableViewCell=@"CCTourTableViewCell";
static NSString *areaCells=@"CCSareaTableViewCell";
@interface CCFarmTourViewController ()< SDCycleScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    int _which;
    UILabel *_label;
    UIButton *_sort;
    NSString *_urlString;
    UIView *_areaView;
    UITableView *_areaTableView;
    UIImageView *_scrollerView;
    UIButton *_Abutton;
    UIImageView *_bgImage;
    UIImageView *_tjImage;
    NSMutableArray *_imageUrls;
    NSMutableArray *_imageNames;
    UITextField *_searchField;
    CCFarmTourTableView *_scrollView1;//南京景点tableview
    CCAdDetailViewController *_adDetailView;
    UIView *_contentView;
    NSString *_str;
   // CCJingDianSearch *_jingdian;
    SDCycleScrollView *_cycleScrollView;
    UIScrollView *_bgscrollView;
    NSInteger _i;
    NSString *_ids;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *datasModel;
@property (nonatomic,strong)NSMutableArray *areaData;
@property (nonatomic,strong)NSMutableArray *jingdianData;
@property (nonatomic,strong)NSMutableArray *commendWay;
@property (nonatomic,assign) NSInteger curPage;
@property (nonatomic,strong)UISearchBar *mySearchBar;
//推荐路线tableview
@property (nonatomic,strong)CCComendTableView *scrollView2;
@property (nonatomic,strong)UIButton *recommend;
@property (nonatomic,assign)NSInteger sortPage;
@property (nonatomic,assign)NSInteger recommendPage;
@end

@implementation CCFarmTourViewController

- (NSMutableArray *)datasModel {
    
    if (!_datasModel) {
        
        _datasModel = [NSMutableArray array];
    }
    
    return _datasModel;
}

- (NSMutableArray *)areaData {
    
    if (!_areaData) {
        
        _areaData = [NSMutableArray array];
    }
    
    return _areaData;
}

- (NSMutableArray *)jingdianData {
    
    if (!_jingdianData) {
        
        _jingdianData = [NSMutableArray array];
    }
    
    return _jingdianData;
}
- (NSMutableArray *)commendWay {
    
    if (!_commendWay) {
        
        _commendWay = [NSMutableArray array];
    }
    
    return _commendWay;
}

- (void)viewDidLoad {
    _which=1;
    _i=1;
    [self requsetAreaData];
    [self requsetData];
    [self addSeachbar];
    
    [self addtour];
    [self requestJingDianData];
    _bgscrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0.0 ,ScreenHeight-(ScreenHeight-100.0/667.0*ScreenHeight), ScreenWidth , ScreenHeight)];
    
    [self.view addSubview:_bgscrollView];
    
    __weak typeof(self) weakSelf = self;
    _bgscrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requsetData2];
        
        if (_which==1) {
            
            [weakSelf requestAreaListData];
            
        }
        if (_which==2) {
            
            [weakSelf requestCommendListData];
        }
    }];

    
    
}

#pragma mark - <上啦加载更多>
- (void)requestAreaListData2 {
    
}

- (void)requestCommendListData2 {
    
}



-(void)requsetAreaData{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=query.farmTour.area&appKey=w4q897jgvxkb&v=1.0&format=json",KURL]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        [_sort removeFromSuperview];
        NSArray *areaList = responseObject[@"areaList"];
        
        self.areaData = [CCClassroomModel
                           mj_objectArrayWithKeyValuesArray:areaList];
//-----设置首次运行的默认值
        _areaModeld=self.areaData[0];
       
       

        [self addtour];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}


#pragma mark 首次广告请求（默认南京）
-(void)requsetData{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?method=query.farmTour.activity&appKey=w4q897jgvxkb&v=1.0&format=json&areaId=44",KURL]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        // NSLog(@"请求成功＝＝JSON: %@", responseObject);
        
        NSArray *article = responseObject[@"article"];
        
        self.datasModel = [CCFarmTourModel
                           mj_objectArrayWithKeyValuesArray:article];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_farmTourModel in self.datasModel) {
            
            
            [_imageUrls addObject:_farmTourModel.image];
            [_imageNames addObject:_farmTourModel.title];
        }
        [self ScrollNetWorkImages];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}

#pragma mark 首次请求景点数据（默认南京）
-(void)requestJingDianData{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.farmTour.spots", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json",@"areaId": @"44", @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        NSArray *article = responseObject[@"article"];
        
        

       // NSLog(@"首次请求经典列表－%@",responseObject);
        self.jingdianData = [CCSecondThredModel
                            mj_objectArrayWithKeyValuesArray:article];
        
       
        _ids = _areaModeld.ids;
        [self setUpScrollView];
        _scrollView1.array=self.jingdianData;
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
       
    }];
   
}

#pragma mark 首次请求推荐路线数据（默认南京）

-(void)ScrollNetWorkImages{
    
    [_cycleScrollView removeFromSuperview];
    
   _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5.0/360.0*ScreenWidth,0.0, ScreenWidth-10.0/360.0*ScreenWidth, 170.0/667.0*ScreenHeight) delegate:self placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
    _cycleScrollView.autoScrollTimeInterval=4;
   
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.titlesGroup = _imageNames;
    // NSLog(@"轮播的文字=%@",_imageNames);
    _cycleScrollView.currentPageDotColor = AppMainColor; // 自定义分页控件小圆标颜色
    _cycleScrollView.imageURLStringsGroup = _imageUrls;
    [_bgscrollView addSubview:_cycleScrollView];
    


}
- (void)setUpScrollView {
    [_scrollView1 removeFromSuperview];
    _bgscrollView.contentSize=CGSizeMake(ScreenWidth, ((_jingdianData.count+2)*137)+(ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-55.5/667.0*ScreenHeight)/667.0*ScreenHeight);
   //----tableView滑动视图－－－
    //[self setscrollerView1];
    _scrollView1 = [[CCFarmTourTableView alloc]initWithFrame:CGRectMake(0.0, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)-40.0/667.0*ScreenHeight, ScreenWidth, ((_jingdianData.count+2)*137)+(ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-55.5/667.0*ScreenHeight)/667.0*ScreenHeight) style:UITableViewStylePlain];
    _scrollView1.scrollEnabled=NO;
    _scrollView1.nav=self.navigationController;
   _scrollView1.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [_bgscrollView addSubview:_scrollView1];
    _curPage = 1;
    
    


}

- (void)handleSortButtonAction {
    
}
- (void)handleRecommendButtonAction {
    
}

- (void)addSeachbar {
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 45.0/667.0*ScreenHeight, ScreenWidth, 50.0/667.0*ScreenHeight)];
    _contentView.backgroundColor = CCColor(235, 235, 235);

    [self.view addSubview:_contentView];
    _mySearchBar = [[UISearchBar alloc]init];
    _mySearchBar.frame = CGRectMake(10.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, ScreenWidth-100.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight);
    _mySearchBar.translucent= YES;
   
     _mySearchBar.placeholder =@"请输入关键词";
    [_mySearchBar setBackgroundImage:[UIImage new]];
    _mySearchBar.layer.borderWidth = 2.0/360.0*ScreenWidth;
    _mySearchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    _mySearchBar.backgroundColor = [UIColor whiteColor];
    _searchField = [_mySearchBar valueForKey:@"_searchField"];
    [_searchField setValue:CCColor(111, 111, 111) forKeyPath:@"_placeholderLabel.textColor"];
    [_searchField setValue:[UIFont boldSystemFontOfSize:15.0/360.0*ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    _mySearchBar.returnKeyType=UIReturnKeySearch;
    _mySearchBar.delegate=self;
   _mySearchBar.layer.cornerRadius = 15.0/360.0*ScreenWidth;
    _mySearchBar.layer.masksToBounds = YES;
    

    
   
   
   [_contentView addSubview:_mySearchBar];
    
    
    UIButton *search=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-123.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, 33.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
    search.backgroundColor=[UIColor clearColor];
    [_contentView addSubview:search];
    [search addTarget:self action:@selector(searchInfor) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *sousuoImage = [[UIImageView alloc]init];
    sousuoImage.frame = CGRectMake(ScreenWidth-123.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, 33.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight);
    sousuoImage.image = [UIImage imageNamed:@"sousuo"];
    [_contentView addSubview:sousuoImage];
    
    /**
     product - scheme - Edit scheme - run - options - application Region选项改为“中国”然后就可以输入中文了 
     */
    
   _label = [[UILabel alloc]init];
    _label.frame = CGRectMake(ScreenWidth - 80.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight, 60.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight);
    
    _label.text =@"南京市";
    _label.textAlignment=NSTextAlignmentLeft;
    
    _label.font = [UIFont systemFontOfSize:12.0/360.0*ScreenWidth];
    _label.textColor = CCColorString(@"#333333");
    [_contentView addSubview:_label];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-25.0/360.0*ScreenWidth, 21.0/667.0*ScreenHeight, 10.0/360.0*ScreenWidth, 8.0/667.0*ScreenHeight)];
    imageView.image=[UIImage imageNamed:@"njy_jiantou"];
    
    UIButton *areaBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 75.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight, 65.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    areaBtn.backgroundColor=[UIColor clearColor];
    [areaBtn addTarget:self action:@selector(areaAction) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:areaBtn];
    
    
    
    [_contentView addSubview:imageView];
    
    
}

-(void)searchInfor{
    
    if (_i==1) {
        if ([self.mySearchBar.text length]<=0) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            return;
        }else{
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.mySearchBar.text] forKey:@"searchwords"];
            
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"jingDian"];
            
            
            
            
            UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCJingDianSearch " bundle:nil] instantiateInitialViewController];
            [self presentViewController:SecondController animated:YES completion:nil];
            
            CCJingDianSearch *search = SecondController.childViewControllers[0];
            search.areaID = _ids;
        }

    }else if (_i==2){
        if ([self.mySearchBar.text length]<=0) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            return;
        }else{
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.mySearchBar.text] forKey:@"searchwords"];
            
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"commend"];
            
            
            
            
            UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCCommendSearch " bundle:nil] instantiateInitialViewController];
            [self presentViewController:SecondController animated:YES completion:nil];
            CCCommendSearch *search = SecondController.childViewControllers[0];
            search.areaID = _ids;
        }

    }
    self.mySearchBar.text=nil;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    if (_i==1) {
        if ([self.mySearchBar.text length]<=0) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        }else{
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.mySearchBar.text] forKey:@"searchwords"];
            
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"jingDian"];
            
            
            
            
            UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCJingDianSearch " bundle:nil] instantiateInitialViewController];
            [self presentViewController:SecondController animated:YES completion:nil];
            
            CCJingDianSearch *search = SecondController.childViewControllers[0];
            search.areaID = _ids;
        }
        
    }else if (_i==2){
        if ([self.mySearchBar.text length]<=0) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        }else{
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.mySearchBar.text] forKey:@"searchwords"];
            
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"commend"];
            
            
            
            
            UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCCommendSearch " bundle:nil] instantiateInitialViewController];
            [self presentViewController:SecondController animated:YES completion:nil];
            CCCommendSearch *search = SecondController.childViewControllers[0];
            search.areaID = _ids;
        }
        
    }
    self.mySearchBar.text=nil;
}


-(void)areaAction{
    //[self requsetAreaData];
    
    
    
    _areaView=[[UIView alloc]initWithFrame:CGRectMake(15.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight, ScreenWidth-30.0/360.0*ScreenWidth, ScreenHeight-40.0/667.0*ScreenHeight)];
    
    _areaView.backgroundColor=[UIColor whiteColor];
    [self.view.window addSubview:_areaView];
    
   
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(2.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight, ScreenWidth-34.0/360.0*ScreenWidth, 1.0/667.0*ScreenHeight)];
    line.backgroundColor=[UIColor grayColor];
    [_areaView addSubview:line];
    
   
    UILabel *aletLable=[[UILabel alloc]initWithFrame:CGRectMake(15.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, 170.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight)];
    aletLable.text=@"请选择城市";
    aletLable.font=[UIFont systemFontOfSize:20.0/360.0*ScreenWidth];
    [_areaView addSubview:aletLable];
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(290.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    [back addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [back setBackgroundImage:[UIImage imageNamed:@"njy_back1"] forState:UIControlStateNormal];
    [_areaView addSubview:back];
    
    _areaTableView=[[UITableView alloc]initWithFrame:CGRectMake(15.0/360.0*ScreenWidth, 65.0/667.0*ScreenHeight, self.view.bounds.size.width-60.0/360.0*ScreenWidth, self.view.bounds.size.height-10.0/667.0*ScreenHeight)];
    _areaTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _areaTableView.delegate=self;
    _areaTableView.dataSource=self;
    [_areaView addSubview:_areaTableView];
    
    
    
}

-(void)removeView{
    [_areaView removeFromSuperview];
    
}

//  =====农家游下半部分
- (void)addtour {

    _sort = [[UIButton alloc ]initWithFrame:CGRectMake(0.0, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)-95.0/667.0*ScreenHeight, ScreenWidth / 2.0-1.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
   
    _str=[_areaModeld.name substringWithRange:NSMakeRange(0, 3)];
    //_sort.titleLabel.text=[NSString stringWithFormat:@"%@景点",str];
    [_sort setTitle:[NSString stringWithFormat:@"%@景点",_str] forState:UIControlStateNormal];
    _sort.tag=1001;
//NSLog(@"首次运行按钮名称====111%@",_areaModeld.name);
   
    [_sort addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
//======设置button的两种状态
    _sort.selected=YES;
    _Abutton=_sort;
    [_sort setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sort setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateSelected];
    
    _bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(23.0/360.0*ScreenWidth, 3.0/667.0*ScreenHeight, 25.0/360.0*ScreenWidth, 25.0/667.0*ScreenHeight)];
    _bgImage.image=[UIImage imageNamed:@"icon_jingdian"];
    [_sort addSubview:_bgImage];
    
    _sort.titleLabel.font = [UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    
    
    [_bgscrollView addSubview:_sort];
    
    
//------推荐路线－－－－
    UIButton *recommend =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth / 2.0+1.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)-95.0/667.0*ScreenHeight, ScreenWidth / 2.0, 30.0/667.0*ScreenHeight)];
    recommend.tag=1012;
    [recommend setTitle:@"推荐路线" forState:UIControlStateNormal];
    
    [recommend addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _tjImage=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth / 2.0+25.0/360.0*ScreenWidth, 3.0/667.0*ScreenHeight, 25.0/360.0*ScreenWidth, 25.0/667.0*ScreenHeight)];
    _tjImage.image=[UIImage imageNamed:@"icon_luxian_nor"];
    [recommend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [recommend setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateSelected];
    recommend.titleLabel.font = [UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    
    
    [_sort addSubview:_tjImage];
    [_bgscrollView addSubview:recommend];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth / 2.0, ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-82.0/667.0*ScreenHeight, 1.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.2;
    [_bgscrollView addSubview:line];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-55.0/667.0*ScreenHeight, ScreenWidth-10.0/360.0*ScreenWidth,   1.0/667.0*ScreenHeight)];
    line2.backgroundColor = [UIColor grayColor];
    line2.alpha = 0.2;
    [_bgscrollView addSubview:line2];
    //---------下划线－－－－－
    //    --创建滑动视图大小
    _scrollerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-55.5/667.0*ScreenHeight, ScreenWidth/2, 2.0/667.0*ScreenHeight)];
   
    //    --添加滑动视图图片
    _scrollerView.image = [UIImage imageNamed:@"njy_hengxian"];
    
    [_bgscrollView addSubview:_scrollerView];
    
    
}

-(void)sortAction:(UIButton*)buttons{
    _Abutton.selected=NO;
    buttons.selected=YES;
   
        _bgImage.image=[UIImage imageNamed:@"icon_jingdian_nor"];
        if (buttons.tag==1001&&buttons.selected==YES) {
            [UIView animateWithDuration:0.3 animations:^{
                _scrollerView.frame=CGRectMake(0, ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-55.5/667.0*ScreenHeight, ScreenWidth/2, 2.0/667.0*ScreenHeight);
                //    --添加滑动视图图片
            }];
            
            
            
            
            [self.scrollView2 removeFromSuperview];
            _which=1;
            _bgImage.image=[UIImage imageNamed:@"icon_jingdian"];
            
           
            [self requestAreaListData];

        }else{
            
            _bgImage.image=[UIImage imageNamed:@"icon_jingdian_nor"];
            
        }
        if (buttons.tag==1012&&buttons.selected==YES) {
            [UIView animateWithDuration:0.3 animations:^{
               _scrollerView.frame=CGRectMake(ScreenWidth/2, ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-55.5/667.0*ScreenHeight, ScreenWidth/2, 2.0/667.0*ScreenHeight);
            }];
            
         
           
            
            [_scrollView1 removeFromSuperview];
            _which=2;
            
            _i=2;
            _tjImage.image=[UIImage imageNamed:@"icon_luxian_pre"];
            
            
           [self requestCommendListData];

            
        }else{
            
            _tjImage.image=[UIImage imageNamed:@"icon_luxian_nor"];
        }
        
        _Abutton=buttons;
    

}



-(void)setscrollerView2{
    [self.scrollView2 removeFromSuperview];
     _bgscrollView.contentSize=CGSizeMake(ScreenWidth, ((_commendWay.count+2)*137)+(ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-55.5/667.0*ScreenHeight)/667.0*ScreenHeight);
    CCComendTableView *tableview= [[CCComendTableView alloc]initWithFrame:CGRectMake(0.0, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)-40.0/667.0*ScreenHeight, ScreenWidth, ((_commendWay.count+2)*137)+(ScreenHeight-(ScreenHeight-265.0/667.0*ScreenHeight)-55.5/667.0*ScreenHeight)/667.0*ScreenHeight) style:UITableViewStylePlain];
    tableview.scrollEnabled=NO;
    self.scrollView2=tableview;
    self.scrollView2.nav=self.navigationController;
    
   
   tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
  
    [_bgscrollView addSubview:self.scrollView2];
}

//----轮播点击方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //NSLog(@"农家游---点击了第%ld张图片", (long)index);
    _cycleScrollView.userInteractionEnabled=NO;
    _farmTourModel=self.datasModel[index];
    _adDetailModel=self.datasModel[index];
    [self requestAdDetailData];
}

//-------农家游活动信息详情请求
-(void)requestAdDetailData{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    //NSLog(@"Rich==%@",_richModel.associateId);
    _urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_farmTourModel.id,ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
       // NSLog(@"NewsFarm请求成功＝＝JSON: %@", responseObject);
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
    _adDetailView.url=_farmTourModel.id;
    _adDetailView.model=_adDetailModel;
    _adDetailView.title=@"农家游";

    
    [self.navigationController pushViewController:_adDetailView animated:YES];
    
    
    
}



//-----选择地区tableview的代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0/667.0*ScreenHeight;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.areaData.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
    
   CCSareaTableViewCell *areaCell=[tableView dequeueReusableCellWithIdentifier:areaCells];

    if (areaCell==nil) {
    areaCell=[[CCSareaTableViewCell alloc]init];
    
    
}
        areaCell.areaModel=_areaData[indexPath.row];
        return areaCell;
    
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_cycleScrollView removeFromSuperview];
    [_scrollView1 removeFromSuperview];
    _areaModeld=self.areaData[indexPath.row];
    
        [self requsetData2];
    
    [_areaView removeFromSuperview];
    [_label removeFromSuperview];
    _label = [[UILabel alloc]init];
    _label.frame = CGRectMake(ScreenWidth - 80.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight, 60.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight);
    NSString *areStr=[NSString stringWithFormat:@"%@",_areaModeld.name];
    _label.text =areStr;
    _label.font = [UIFont systemFontOfSize:12.0/360.0*ScreenWidth];
    _label.textAlignment=NSTextAlignmentLeft;
    _label.textColor = CCColorString(@"#333333");
    [_contentView addSubview:_label];
    if (_which==1) {
        //_sort.titleLabel.text=nil;
        _str=[_areaModeld.name substringWithRange:NSMakeRange(0, 3)];
        
        [_sort setTitle:[NSString stringWithFormat:@"%@景点",_str] forState:UIControlStateNormal];
        
        _label.font = [UIFont systemFontOfSize:14.0/360.0*ScreenWidth];
    [self requestAreaListData ];
    }
   
    if (_which==2) {
        //_sort.titleLabel.text=nil;
        _str=[_areaModeld.name substringWithRange:NSMakeRange(0, 3)];
        
        [_sort setTitle:[NSString stringWithFormat:@"%@景点",_str] forState:UIControlStateNormal];
        
        _label.font = [UIFont systemFontOfSize:14.0/360.0*ScreenWidth];
        [self requestCommendListData];
    }
    
    
}


#pragma mark 根据城市id来请求景点列表数据
-(void)requestAreaListData{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.farmTour.spots", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json",@"areaId": [NSString stringWithFormat:@"%@",_areaModeld.ids], @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
   
    _ids = _areaModeld.ids;
    
    
    
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        
      
        
        NSArray *article = responseObject[@"article"];
        
        self.jingdianData = [CCSecondThredModel
                             mj_objectArrayWithKeyValuesArray:article];

            [self setUpScrollView];
       _scrollView1.array=self.jingdianData;
        [_scrollView1 reloadData];
         [_bgscrollView.mj_header endRefreshing];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
       
                [_bgscrollView.mj_header endRefreshing];
    }];

}
#pragma mark 根据城市id来请求推荐路线数据
-(void)requestCommendListData{
   
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.farmTour.tour", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json",@"areaId": [NSString stringWithFormat:@"%@",_areaModeld.ids], @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        _curPage ++;
        
        CCCommendSearch *commend=[[CCCommendSearch alloc]init];
        commend.areaID=_areaModeld.ids;
        
//NSLog(@"推荐路线列表数据－==%@",responseObject);
        
        NSArray *article = responseObject[@"article"];
        
        self.commendWay = [CCSecondThredModel
                             mj_objectArrayWithKeyValuesArray:article];

            [self setscrollerView2];

        _scrollView2.array=self.commendWay;
        [_scrollView2 reloadData];
        
        [_bgscrollView.mj_header endRefreshing];
    
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
       [_bgscrollView.mj_header endRefreshing];
    }];
    
}


-(void)requsetData2{
    
    NSString *string=[NSString stringWithFormat:@"%@?method=query.farmTour.activity&appKey=w4q897jgvxkb&v=1.0&format=json&areaId=%@",KURL,_areaModeld.ids];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:string parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//NSLog(@"请求成功＝＝JSON: %@", responseObject);
        
        NSArray *article = responseObject[@"article"];
       
        self.datasModel = [CCFarmTourModel
                           mj_objectArrayWithKeyValuesArray:article];
        _imageNames=[[NSMutableArray alloc]init];
        _imageUrls=[[NSMutableArray alloc]init];
        
        for (_farmTourModel in self.datasModel) {
            
            
            [_imageUrls addObject:_farmTourModel.image];
            [_imageNames addObject:_farmTourModel.title];
        }
        [self ScrollNetWorkImages];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _cycleScrollView.userInteractionEnabled=YES;
    
    
}




@end
