//
//  CCMapViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/11/11.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCMapViewController.h"
#import "CCSearRoadLineViewController.h"
@interface CCMapViewController ()
{
    UIImageView *_image;
    UILabel *_lable;
    UIButton *_btn2;
}
@end

@implementation CCMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self setBaseView];
}

-(void)setBaseView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0,0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    

   
}

-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    
    // 添加一个PointAnnotation
    NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"NZGdetail"];
    NSString *latitude=[dics objectForKey:@"lat"];
    NSString *longitude=[dics objectForKey:@"lon"];
    
    double lat=latitude.doubleValue;
    double lon=longitude.doubleValue;
    //latitude
    //longitude
    CLLocationCoordinate2D latss =CLLocationCoordinate2DMake(lat, lon);
    
    _mapView.centerCoordinate = latss;
    
    _mapView.zoomLevel = 19;//地图显示比例
    self.view = _mapView;
    UIImageView *image = [[UIImageView alloc]init];
    image.frame = CGRectMake(ScreenWidth-100.0/367.0*ScreenWidth,40.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    _image=image;
    image.image= [UIImage imageNamed:@"daozheli"];
    [self.navigationController.view addSubview:image];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-79.0/367.0*ScreenWidth,40.0/667.0*ScreenHeight, 70.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight)];
    _lable=lable;
    lable.text=@"到这去";
    lable.textColor=[UIColor whiteColor];
    [self.navigationController.view addSubview:lable];
    
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-100.0/367.0*ScreenWidth,40.0/667.0*ScreenHeight, 100.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight)];
    _btn2=btn2;
    btn2.backgroundColor=[UIColor clearColor];
    
    [btn2 addTarget:self action:@selector(goThere) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:btn2];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goThere{
    CCSearRoadLineViewController *line=[[CCSearRoadLineViewController alloc]init];
   
    line.title=@"展馆导航";
    [self.navigationController pushViewController:line animated:YES];

}

-(void)viewWillDisappear:(BOOL)animated{
    [_image removeFromSuperview];
    [_lable removeFromSuperview];
    [_btn2 removeFromSuperview];
    [_mapView removeFromSuperview];
}

- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    _mapView.delegate=self;
     NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"NZGdetail"];
    NSString *latitude=[dics objectForKey:@"lat"];//纬度
    NSString *longitude=[dics objectForKey:@"lon"];//经度
     NSString *name=[dics objectForKey:@"name"];
    
    double lat=latitude.doubleValue;
    double lon=longitude.doubleValue;
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = lat;//纬度
    coor.longitude = lon;//经度
    
    annotation.coordinate = coor;
    annotation.title = name;
    [_mapView addAnnotation:annotation];
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.annotation=annotation;
        newAnnotationView.image = [UIImage imageNamed:@"nzg_adress-1"];   //把大头针换成别的图片icon_marka
        [newAnnotationView setSelected:YES animated:YES];
        return newAnnotationView;
    }
    return nil;
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
