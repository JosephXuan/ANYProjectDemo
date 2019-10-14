//
//  CCSecListWebViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/30.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSecListModel.h"
#import <MediaPlayer/MediaPlayer.h>
@interface CCSecListWebViewController : UIViewController
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)UIWebView *webView;
@property (nonatomic,strong)CCSecListModel *model;

@end
