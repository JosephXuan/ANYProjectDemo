//
//  CCNoticDeWebViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/10/9.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCNoticDetailModel.h"

@interface CCNoticDeWebViewController : UIViewController
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)UIWebView *webView;
@property (nonatomic,strong)CCNoticDetailModel *model;

@end
