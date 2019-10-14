//
//  CCDetailMapViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/11/16.
//  Copyright © 2016年 李孝帅. All rights reserved.
//
//导航界面
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface CCDetailMapViewController : UIViewController  <BMKMapViewDelegate,BMKRouteSearchDelegate>
{
    BMKRouteSearch* _routesearch;
}
@property (nonatomic,strong)BMKMapView* mapView;
@property (nonatomic,assign)int which;
@property (nonatomic,assign)CLLocationCoordinate2D pt;
@property (nonatomic,copy)NSString *start;
@property (nonatomic,copy)NSString *end;
@end
