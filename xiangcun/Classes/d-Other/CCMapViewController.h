//
//  CCMapViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/11/11.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
@interface CCMapViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>{
    IBOutlet BMKMapView* _mapView;
}

@end
