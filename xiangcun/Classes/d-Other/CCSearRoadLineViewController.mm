//
//  CCSearRoadLineViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/11/11.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCSearRoadLineViewController.h"
#import "CCLineViewController.h"
#import "UIImage+Rotate.h"
#import "RouteAnnotation.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]


@interface CCSearRoadLineViewController ()
{
    UIButton *_aButton;
    NSString *_endName;
    int _which;
    bool isGeoSearch;
    NSString* _showmeg;
    CLLocationCoordinate2D _pt;
    CLLocationCoordinate2D _pt2;
}
@property (nonatomic,strong)UITextField *startPointTex;
@property (nonatomic,strong)UITextField *endPointTex;
@property (nonatomic,strong)NSMutableArray *array;
@end
//@interface RouteAnnotation : BMKPointAnnotation
//{
//    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
//    int _degree;
//}
//
//@property (nonatomic) int type;
//@property (nonatomic) int degree;
//@end
//
//@implementation RouteAnnotation
//
//@synthesize type = _type;
//@synthesize degree = _degree;
//@end

@implementation CCSearRoadLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _which=1;
    _locService = [[BMKLocationService alloc]init];//定位功能的初始化
    
    
    
//    _routesearch = [[BMKRouteSearch alloc]init];
    
    NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"NZGdetail"];
    NSString *name=[dics objectForKey:@"name"];
    _endName=name;
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f4f4f4"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0,0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self setBaseView];
    _array=[[NSMutableArray alloc]init];
    
    
    
}



-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBaseView{
    UIButton *busButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-80.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight, 30.0/360.0*ScreenWidth, 30.0/360.0*ScreenWidth)];
    busButton.selected=YES;
    _aButton=busButton;
    busButton.tag=2001;
    [busButton addTarget:self action:@selector(choice:) forControlEvents:UIControlEventTouchUpInside];
    [busButton setBackgroundImage:[UIImage imageNamed:@"icon_bus_nor"] forState:UIControlStateNormal];
    [busButton setBackgroundImage:[UIImage imageNamed:@"icon_bus_pre"] forState:UIControlStateSelected];
    [self.view addSubview:busButton];
    
    UIButton *carButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, 18.0/667.0*ScreenHeight, 30.0/360.0*ScreenWidth, 30.0/360.0*ScreenWidth)];
    [carButton addTarget:self action:@selector(choice:) forControlEvents:UIControlEventTouchUpInside];
    carButton.tag=2002;
    [carButton setBackgroundImage:[UIImage imageNamed:@"icon_car_nor"] forState:UIControlStateNormal];
    [carButton setBackgroundImage:[UIImage imageNamed:@"icon_car_pre"] forState:UIControlStateSelected];
    [self.view addSubview:carButton];
    
    UIButton *walkButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2+80.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight, 30.0/360.0*ScreenWidth, 30.0/360.0*ScreenWidth)];
    [walkButton addTarget:self action:@selector(choice:) forControlEvents:UIControlEventTouchUpInside];
    walkButton.tag=2003;
    [walkButton setBackgroundImage:[UIImage imageNamed:@"icon_walk_nor"] forState:UIControlStateNormal];
    [walkButton setBackgroundImage:[UIImage imageNamed:@"icon_walk_pre"] forState:UIControlStateSelected];
    [self.view addSubview:walkButton];
    
    UITextField *myLocation=[[UITextField alloc]initWithFrame:CGRectMake((ScreenWidth-200.0/360.0*ScreenWidth)/2, 100.0/667.0*ScreenHeight, 230.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];
    myLocation.layer.borderWidth=1;
    myLocation.layer.borderColor=[UIColor colorWithHexString:@"#404040"].CGColor;
    myLocation.layer.cornerRadius=15.0/360.0*ScreenWidth;
    myLocation.layer.masksToBounds=YES;
    myLocation.textColor=[UIColor colorWithHexString:@"#1ab750"];
    myLocation.font=[UIFont systemFontOfSize:13.0/360.0*ScreenWidth];
//   myLocation.placeholder=@"我的位置";
//    myLocation.text=@"我的位置（玄武大道36号）";
    [myLocation setValue:[UIColor colorWithHexString:@"#1ab750"] forKeyPath:@"_placeholderLabel.textColor"];
    [myLocation setValue:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    self.startPointTex=myLocation;
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(0.0, 16.0/667.0*ScreenHeight, 45.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    left.backgroundColor=[UIColor clearColor];
    myLocation.leftView=left;
    myLocation.leftViewMode=UITextFieldViewModeAlways;
    
    UIImageView *picImage=[[UIImageView alloc]initWithFrame:CGRectMake(17.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight, 16.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    picImage.image=[UIImage imageNamed:
                     @"daohang_green"];
    [myLocation addSubview:picImage];
    
    [self.view addSubview:myLocation];
    
    
    
    UITextField *endLocation=[[UITextField alloc]initWithFrame:CGRectMake((ScreenWidth-200.0/360.0*ScreenWidth)/2, 188.0/667.0*ScreenHeight, 230.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];
    endLocation.userInteractionEnabled = NO;
    endLocation.textColor=[UIColor colorWithHexString:@"#404040"];
    endLocation.font=[UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    endLocation.layer.borderWidth=1;
    endLocation.layer.borderColor=[UIColor colorWithHexString:@"#404040"].CGColor;
    endLocation.layer.cornerRadius=15.0/360.0*ScreenWidth;
    endLocation.layer.masksToBounds=YES;
    endLocation.text=_endName;
    self.endPointTex=endLocation;
    UIView *left2 = [[UIView alloc]initWithFrame:CGRectMake(0.0, 16.0/667.0*ScreenHeight, 45.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    left2.backgroundColor=[UIColor clearColor];
    endLocation.leftView=left2;
    endLocation.leftViewMode=UITextFieldViewModeAlways;
    
    UIImageView *picImage2=[[UIImageView alloc]initWithFrame:CGRectMake(17.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight, 16.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    picImage2.image=[UIImage imageNamed:
                    @"daohang_red"];
    [endLocation addSubview:picImage2];
    
    [self.view addSubview:endLocation];
    
    
    UIButton *search=[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-200.0/360.0*ScreenWidth)/2, 286.0/667.0*ScreenHeight, 230.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];
    search.userInteractionEnabled = YES;
    [search setTitle:@"查询路线" forState:UIControlStateNormal];
    [search setBackgroundColor:[UIColor colorWithHexString:@"#1ab750"]];
    search.titleLabel.font=[UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    search.layer.cornerRadius=15.0/360.0*ScreenWidth;
    search.layer.masksToBounds=YES;
    [search addTarget:self action:@selector(searchRoadLine) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:search];
    
}
#pragma mark --选择导航方式
-(void)choice:(UIButton *)button{
    _aButton.selected=NO;
    button.selected=YES;
    if (button.tag==2001) {
        _which=1;
    }if (button.tag==2002) {
        _which=2;
    }if (button.tag==2003) {
        _which=3;
    }
    _aButton=button;
}

-(void)searchRoadLine{
    _detailMapView=[[CCDetailMapViewController alloc]init];

    _detailMapView.which=_which;
    if ([self.startPointTex.text isEqualToString:_showmeg]) {
        _detailMapView.start=_showmeg;
        _detailMapView.pt=_pt;
//        NSLog(@"_detailMapView经度=%f,纬度=%f",_detailMapView.pt.longitude,_detailMapView.pt.latitude);
    
        [self.navigationController pushViewController:_detailMapView animated:YES];
    }else{
        isGeoSearch = true;
        BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geocodeSearchOption.city= @"南京";
        geocodeSearchOption.address = self.startPointTex.text;
        BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }
        
        
       _detailMapView.start=self.startPointTex.text;
//    _detailMapView.pt=_pt2;
    
    }
     NSLog(@"_showmeg%@",_showmeg);
    _detailMapView.end=_endName;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        
//        
//    });
    
    
    
    
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    _pt2 = (CLLocationCoordinate2D){0, 0};//初始化
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
       
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"正向地理编码";
        showmeg = [NSString stringWithFormat:@"纬度:%f,经度:%f",item.coordinate.latitude,item.coordinate.longitude];
        _pt2 = (CLLocationCoordinate2D){item.coordinate.latitude,
            item.coordinate.longitude};
       
        _detailMapView.start=self.startPointTex.text;
        _detailMapView.pt=_pt2;
        [self.navigationController pushViewController:_detailMapView animated:YES];
    }
}



-(void)viewWillAppear:(BOOL)animated {
    
    //启动LocationService
    [_locService startUserLocationService];//启动定位服务
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geocodesearch.delegate = self;//设置代理为self
    _locService.delegate = self;//设置代理位self
   
    
    
   
}
-(void)viewDidAppear:(BOOL)animated{
    isGeoSearch = false;
    _pt = (CLLocationCoordinate2D){0, 0};//初始化
    if (_locService.userLocation.location.coordinate.longitude!= 0
        && _locService.userLocation.location.coordinate.latitude!= 0) {
        //如果还没有给pt赋值,那就将当前的经纬度赋值给pt
        _pt = (CLLocationCoordinate2D){_locService.userLocation.location.coordinate.latitude,
            _locService.userLocation.location.coordinate.longitude};
        NSLog(@"经度=%f,纬度=%f",_pt.longitude,_pt.latitude);
        
        
        
        
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.reverseGeoPoint = _pt;//设置反编码的店为pt
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
/**
 *  /// 街道号码
 @property (nonatomic, strong) NSString* streetNumber;
 /// 街道名称
 @property (nonatomic, strong) NSString* streetName;
 /// 区县名称
 @property (nonatomic, strong) NSString* district;
 /// 城市名称
 @property (nonatomic, strong) NSString* city;
 /// 省份名称
 @property (nonatomic, strong) NSString* province;
 
 */
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title =[NSString stringWithFormat:@"%@%@%@%@",result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
        
        
        
        _showmeg = [NSString stringWithFormat:@"%@",item.title];
//        self.addr.text = showmeg;
        
            self.startPointTex.text=_showmeg;
        
    }
}
-(void)viewWillDisappear:(BOOL)animated {
     _locService.delegate = nil;
   _geocodesearch.delegate = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
