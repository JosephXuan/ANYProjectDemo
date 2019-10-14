//
//  CCSearRoadLineViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/11/11.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "CCDetailMapViewController.h"
@interface CCSearRoadLineViewController : UIViewController <BMKMapViewDelegate, BMKRouteSearchDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate> {
     CCDetailMapViewController* _detailMapView;
    BMKLocationService* _locService;
    BMKGeoCodeSearch *_geocodesearch;
    BMKRouteSearch* _routesearch;
}

@end
