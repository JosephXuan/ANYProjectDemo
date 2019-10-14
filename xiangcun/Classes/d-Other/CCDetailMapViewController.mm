//
//  CCDetailMapViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/11/16.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCDetailMapViewController.h"
#import "CCLineViewController.h"
#import "UIImage+Rotate.h"
#import "RouteAnnotation.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
@interface CCDetailMapViewController (){
    int _times;
    int _distences;
    CCLineViewController*_lineView;
    CLLocationCoordinate2D _latss2;
    
}
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic, strong) BMKSuggestAddrInfo* suggestAddrResult;
@end

@implementation CCDetailMapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [_mapView viewWillAppear];
    self.title=@"路线导航";
    _lineView=[[CCLineViewController alloc]init];
    _routesearch = [[BMKRouteSearch alloc]init];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _routesearch.delegate=self;
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0,0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    _array=[[NSMutableArray alloc]init];
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
    
    UIBarButtonItem* btnWayPoint = [[UIBarButtonItem alloc]init];
    btnWayPoint.target = self;
    btnWayPoint.action = @selector(wayPointDemo);
    btnWayPoint.title = @"详情";
    btnWayPoint.enabled=TRUE;
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = btnWayPoint;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)wayPointDemo {
    
    
    
    [self.navigationController pushViewController:_lineView animated:YES];
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"NZGdetail"];
    NSString *latitude=[dics objectForKey:@"lat"];
    NSString *longitude=[dics objectForKey:@"lon"];
    
    double lat=latitude.doubleValue;
    double lon=longitude.doubleValue;
    
    _latss2 =CLLocationCoordinate2DMake(lat, lon);
    if (_which==1) {
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        //公交
        start.pt=_pt;
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        end.pt =_latss2;
        BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
        transitRouteSearchOption.city= @"南京市";
        transitRouteSearchOption.from = start;
        transitRouteSearchOption.to = end;
        BOOL flag = [_routesearch transitSearch:transitRouteSearchOption];
        
        if(flag)
        {
            NSLog(@"bus检索发送成功");
            NSLog(@"bus检索发送成功==%@",_routesearch);
            
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"检索发送失败，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            NSLog(@"bus检索发送失败");
        }
    }if (_which==2) {
        //驾车
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        start.pt=_pt;
        start.cityName = @"南京市";
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        end.pt =_latss2;
        
        
        BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
        drivingRouteSearchOption.from = start;
        drivingRouteSearchOption.to = end;
        drivingRouteSearchOption.drivingRequestTrafficType = BMK_DRIVING_REQUEST_TRAFFICE_TYPE_NONE;//不获取路况信息
        BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
        if(flag)
        {
            NSLog(@"car检索发送成功");
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"检索发送失败，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            NSLog(@"car检索发送失败");
        }
    }if (_which==3) {
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        start.pt=_pt;
        
        start.cityName = @"南京市";
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        end.pt =_latss2;
        
        
        //走路
        BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
        walkingRouteSearchOption.from = start;
        walkingRouteSearchOption.to = end;
        BOOL flag = [_routesearch walkingSearch:walkingRouteSearchOption];
        if(flag)
        {
            NSLog(@"walk检索发送成功");
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"检索发送失败，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            NSLog(@"walk检索发送失败");
        }
    }

  
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _routesearch.delegate=nil;
}
#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{

    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [(RouteAnnotation*)annotation getRouteAnnotationView:view];
    }
     
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
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
#pragma mark - BMKRouteSearchDelegate
//公交
- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
        
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
    
        
        
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:4];
        // 计算路线方案中的路段数目
    NSLog(@"%lu",(unsigned long)plan.steps.count);
        
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 2;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        _times=0;
        _distences=0;
        [_array removeAllObjects];
        
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int time=transitStep.duration;
            int distance=transitStep.distance;
            NSLog(@"transitStep.instruction==%@",transitStep.instruction);
            [_array addObject:transitStep.instruction];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
            _times+=time;
            _distences+=distance;
            
        }
    //多少分钟
        float  mint=(_times/60);
    //多少公里
        float  disten=(_distences/1000);
#pragma mark - //先移除，防止累加
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lineTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lineDistance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
#pragma mark - //将计算结果存成全局
        NSString *string = [NSString stringWithFormat:@"%0.2f",mint];
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",string] forKey:@"time"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"lineTime"];
        
        NSString *string2 = [NSString stringWithFormat:@"%0.2f",disten];
        NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",string2] forKey:@"distance"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic2 forKey:@"lineDistance"];
        
        if (plan==NULL) {
            NSLog(@"error==%u",error);
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"抱歉，暂未搜到合适路线，请更换起点重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }else{
            //            _lineView = [[CCLineViewController alloc]init];
            
            _lineView.title = @"路线详情";
            _lineView.arrays=_array;
            _lineView.start=_start;
        }
        
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
   
    
    
        
    
}

/**
 *  ///路线打车描述信息
 @property (nonatomic, strong) NSString* desc;
 ///总路程，单位： 米
 @property (nonatomic) int distance;
 ///总耗时，单位： 秒
 @property (nonatomic) int duration;
 ///每千米单价，单位 元
 @property (nonatomic) float perKMPrice;
 ///总价 , 单位： 元
 @property (nonatomic) int totalPrice; */
//驾车
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            NSLog(@"%@   %@    %@", transitStep.entraceInstruction, transitStep.exitInstruction, transitStep.instruction);
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        _times=0;
        _distences=0;
        [_array removeAllObjects];
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            float time=transitStep.duration;
            NSLog(@"transitStep.duration==%d",transitStep.duration);
            int distance=transitStep.distance;
            [_array addObject:transitStep.instruction];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            _times+=time;
            _distences+=distance;
            
        }

//    BMKRouteLine* routePlan = (BMKRouteLine*)[result.routes objectAtIndex:0];
 
    float  mint = plan.duration.minutes;
//        float  mint=(_times/60);
        float  disten=(_distences/1000);
#pragma mark - //先移除，防止累加
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lineTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lineDistance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
#pragma mark - //将计算结果存成全局
        NSString *string = [NSString stringWithFormat:@"%0.2f",mint];
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",string] forKey:@"time"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"lineTime"];
        
        NSString *string2 = [NSString stringWithFormat:@"%0.2f",disten];
        NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",string2] forKey:@"distance"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic2 forKey:@"lineDistance"];
        
        if (plan==NULL) {
            NSLog(@"erroe==%u",error);
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"抱歉，暂未搜到合适路线，请更换起点重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }else{
            
            _lineView.title = @"路线详情";
            _lineView.arrays=_array;
            _lineView.start=_start;
            
        }
        
        
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
        
    
}
//步行
- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        _times=0;
        _distences=0;
        [_array removeAllObjects];
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int time=transitStep.duration;
            int distance=transitStep.distance;
            [_array addObject:transitStep.instruction];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            _times+=time;
            _distences+=distance;
            
        }
        float  mint=(_times/60);
        float  disten=(_distences/1000);
#pragma mark - //先移除，防止累加
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lineTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lineDistance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
#pragma mark - //将计算结果存成全局
        NSString *string = [NSString stringWithFormat:@"%0.2f",mint];
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",string] forKey:@"time"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"lineTime"];
        
        NSString *string2 = [NSString stringWithFormat:@"%0.2f",disten];
        NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",string2] forKey:@"distance"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic2 forKey:@"lineDistance"];
        
        if (plan==NULL) {
            NSLog(@"erroe==%u",error);
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"抱歉，暂未搜到合适路线，请更换起点重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }else{
            
            _lineView.title = @"路线详情";
            _lineView.arrays=_array;
            _lineView.start=_start;
            
        }
        
        
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
        
    
}



#pragma mark - 私有

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.8;
}
@end
