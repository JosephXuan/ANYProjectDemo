//
//  CCAdDetailViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/30.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAdDetailModel.h"
#import <MediaPlayer/MediaPlayer.h>
@interface CCAdDetailViewController : UIViewController
@property(nonatomic,copy)NSString *url;
@property (nonatomic,strong)CCAdDetailModel *model;
@property (nonatomic,strong)MPMoviePlayerController *player;
@property(nonatomic,copy)UIWebView *webView;


@end
