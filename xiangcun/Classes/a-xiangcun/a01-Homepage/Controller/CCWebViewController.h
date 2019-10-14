//
//  CCWebViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/29.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDetailModel.h"
#import "AFNetworking.h"

@interface CCWebViewController : UIViewController
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)UIWebView *webView;
@property (nonatomic,strong)CCDetailModel *model;

//-(BOOL)connectdedToNetwork;

@end
