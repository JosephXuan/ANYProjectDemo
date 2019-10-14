//
//  CCNoticDeWebViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/9.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCNoticDeWebViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import <ShareSDK/ShareSDK.h>
#import "CCShareCustom.h"

@interface CCNoticDeWebViewController ()<UIWebViewDelegate>{
    NSString *_ids;
    NSString *_imageUrl;
    NSString *_shareUrl;
    NSString *_shareTitle;
    NSString *_shareDetail;
    
}
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *timeLble;
@end

@implementation CCNoticDeWebViewController

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0/360.0*ScreenWidth, 130.0/667.0*ScreenHeight, self.view.bounds.size.width, ScreenHeight-120.0/667.0*ScreenHeight)];
        _webView.backgroundColor=[UIColor whiteColor];
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
        
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(25.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, 320.0/360.0*ScreenWidth, 90.0)];
      
        _titleLable.numberOfLines=0;
        
        

        [self.view addSubview:_titleLable];
       
        _timeLble=[[UILabel alloc]initWithFrame:CGRectMake(35.0/360.0*ScreenWidth, 110.0/667.0*ScreenHeight, 320.0/360.0*ScreenWidth, 15.0)];
        
        _timeLble.numberOfLines=0;
        [_timeLble setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
        _timeLble.textColor=[UIColor colorWithHexString:@"#848484"];
        [self.view addSubview:_timeLble];
        
        
        
    }
    
    return self;
}

-(void)requestData{
    
    NSString *url=[NSString stringWithFormat:@"%@?method=query.article.share&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@",KURL,_url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:url parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
       
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"shareDic"];
        NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"shareDic"];
        
        _shareUrl=[dic objectForKey:@"shareUrl"];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
    
}

-(void)share{
    [CCShareCustom idString:_url];
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"icon120"]];
    
    if (imageArray) {
        
        NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];
        [publishContent SSDKSetupShareParamsByText:_shareUrl
                                         images:imageArray
                                            url:[NSURL URLWithString:_shareUrl]
                                          title:@"公告"
                                           type:SSDKContentTypeAuto];
       [CCShareCustom shareWithContent:publishContent];
        
    }
}

-(void)setModel:(CCNoticDetailModel *)model{
    if (_model!=model) {
        
        _model=model;
        
       
        [_webView loadHTMLString:_model.content baseURL:nil];
        _titleLable.text=_model.title;
        if (_titleLable.text.length>35) {
            [_titleLable setFont:[UIFont systemFontOfSize:17.0/360.0*ScreenWidth]];
        }else{
            [_titleLable setFont:[UIFont systemFontOfSize:20.0/360.0*ScreenWidth]];
        }
        _timeLble.text=_model.createDateStr;
        _ids=_model.ids;
       
        [self requestData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"公告";
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
