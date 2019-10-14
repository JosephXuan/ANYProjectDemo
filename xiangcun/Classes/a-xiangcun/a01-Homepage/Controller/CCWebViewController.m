//
//  CCWebViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/29.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCWebViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import <ShareSDK/ShareSDK.h>
#import "CCShareCustom.h"

@interface CCWebViewController ()<UIWebViewDelegate>
{
    MPMoviePlayerController *_player;
    UIImageView *_playerImage;
    UIButton *_playButton;
    NSString *_ids;
    NSString *_imageUrl;
    NSString *_shareUrl;
    NSString *_shareTitle;
    NSString *_shareDetail;
    
}
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *fromeLable;
@end

@implementation CCWebViewController

-(instancetype)init{
    
    self = [super init];
    if (self) {
    
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor=[UIColor whiteColor];
//        _webView.scrollView.bounces=NO;
        _webView.opaque=NO;
        _webView.delegate = self;
        [self.view addSubview:_webView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0.0,0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
        [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        btn2.frame = CGRectMake(0.0,0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
        [btn2 setBackgroundImage:[UIImage imageNamed:@"xiangqing_more"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
        
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(25.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, 320.0/360.0*ScreenWidth, 50.0)];
        
        _titleLable.numberOfLines=0;

        [self.view addSubview:_titleLable];
        
        _fromeLable=[[UILabel alloc]initWithFrame:CGRectMake(35.0/360.0*ScreenWidth, 60.0/667.0*ScreenHeight, 320.0/360.0*ScreenWidth, 30.0)];
        _fromeLable.font=[UIFont systemFontOfSize:13.0/360.0*ScreenWidth];
        _fromeLable.textColor=[UIColor colorWithHexString:@"#686767"];
        _fromeLable.numberOfLines=0;
        
        
        [self.view addSubview:_fromeLable];

            }
    
    return self;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)requestData{
    NSString *url=[NSString stringWithFormat:@"%@?method=query.article.share&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@",KURL,_url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:url parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
       // NSLog(@"大课堂分享内容＝＝JSON: %@", responseObject);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"shareDic"];
        NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"shareDic"];
        _imageUrl=[dic objectForKey:@"image"];
        _shareUrl=[dic objectForKey:@"shareUrl"];
        _shareTitle=[dic objectForKey:@"title"];
        _shareDetail=[dic objectForKey:@"description"];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
    
}

-(void)share{
    [CCShareCustom idString:_url];
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"log"]];
    
    if (imageArray) {
        
        NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];
        [publishContent SSDKSetupShareParamsByText:_shareDetail
                                         images:@[_imageUrl]
                                            url:[NSURL URLWithString:_shareUrl]
                                          title:_shareTitle
                                           type:SSDKContentTypeAuto];
        [CCShareCustom shareWithContent:publishContent];
        
    }
}

-(void)play{
    
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status==-1){
            NSLog(@"未识别的网络");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用，请检查网络设置" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            
        }if (status==0){
            
            NSLog(@"不可达的网络(未连接)");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用，请检查网络设置" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }if (status==1){
            NSLog(@"2G,3G,4G...的网络");
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您当前处于移动网络下，继续播放可能会消耗您的流量，是否继续" preferredStyle:UIAlertControllerStyleAlert ];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                [_playerImage removeFromSuperview];
                [_playButton removeFromSuperview];
                [_player play];
                
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }if (status==2){
            NSLog(@"wifi的网络");
            [_playerImage removeFromSuperview];
            [_playButton removeFromSuperview];
            [_player play];
        }
    }];

    
    [manager startMonitoring];
    
   
    
    
}

-(void)setModel:(CCDetailModel *)model{
    if (_model!=model) {
        
        _model=model;
        if ([_model.video isEqualToString:@""]) {
            if ([_model.copyfrom isEqualToString:@""]) {
                _fromeLable.text=nil;
                _webView.frame=CGRectMake(0.0, 70.0/667.0*ScreenHeight, self.view.bounds.size.width, ScreenHeight-169.0/667.0*ScreenHeight);
            }else{
                _fromeLable.text=[NSString stringWithFormat:@"信息来源：%@",_model.copyfrom];
                _webView.frame=CGRectMake(0.0, 100.0/667.0*ScreenHeight, self.view.bounds.size.width, ScreenHeight-169.0/667.0*ScreenHeight);
                
            }
            
        }else {
            _player=[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:_model.video]];
            _player.controlStyle=MPMovieControlStyleEmbedded;
            
            
            
            [self.view addSubview:_player.view];
            _playerImage=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0,self.view.bounds.size.width, 200.0/667.0*ScreenHeight)];
            [_playerImage sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
            _playerImage.userInteractionEnabled=YES;
            [_player.view addSubview:_playerImage];
            
            _playButton=[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-30.0/360.0*ScreenWidth)/2, (200.0/667.0*ScreenHeight-30.0/667.0*ScreenHeight)/2, 50.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];
            [_playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
            [_playButton setBackgroundImage:[UIImage imageNamed:@"banner_bofang"] forState:UIControlStateNormal];
            
            [_playerImage addSubview:_playButton];
            
            if ([_model.copyfrom isEqualToString:@""]) {
                _player.view.frame=CGRectMake(0.0, 70.0/667.0*ScreenHeight, self.view.bounds.size.width, 200.0/667.0*ScreenHeight);
                _fromeLable.text=nil;
                _webView.frame =CGRectMake(0.0, 280.0/667.0*ScreenHeight, self.view.bounds.size.width, ScreenHeight-369.0/667.0*ScreenHeight);
                
                
            }else{
                _player.view.frame=CGRectMake(0.0, 110.0/667.0*ScreenHeight, self.view.bounds.size.width, 200.0/667.0*ScreenHeight);
                _fromeLable.text=[NSString stringWithFormat:@"信息来源：%@",_model.copyfrom];
                _webView.frame =CGRectMake(0.0, 320.0/667.0*ScreenHeight, self.view.bounds.size.width, ScreenHeight-409.0/667.0*ScreenHeight);
            }
            
            _webView.delegate = self;
            
        }
       
     [_webView loadHTMLString:_model.content baseURL:nil];
      _titleLable.text=_model.title;
        if (_titleLable.text.length>35) {
            [_titleLable setFont:[UIFont systemFontOfSize:17.0/360.0*ScreenWidth]];
        }else{
            [_titleLable setFont:[UIFont systemFontOfSize:20.0/360.0*ScreenWidth]];
        }
        _ids=_model.ids;
        //NSLog(@"分享的资讯id2%@",_url);
        [self requestData];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   [self setModel:_model];
    self.view.backgroundColor=[UIColor whiteColor];
   self.title=@"爱农易";
    
    }
-(void)viewWillDisappear:(BOOL)animated{
    if (_player.fullscreen==YES) {
    _player.controlStyle=MPMovieControlStyleEmbedded;
        
        return;
    }else{
        [_player stop];
    }
    
}


- (void)setUrl:(NSString *)url {
    
    
    _url = url;
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Disable user selection
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
