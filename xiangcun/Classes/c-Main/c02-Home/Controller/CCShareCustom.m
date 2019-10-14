//
//  CCShareCustom.m
//  xiangcun
//
//  Created by 李孝帅 on 16/11/9.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCShareCustom.h"
#import <QuartzCore/QuartzCore.h>
#import <ShareSDK/ShareSDK.h>
#import "AFNetworking.h"
#import "CCLoginViewController.h"

//设备物理大小
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion floatValue]
//屏幕宽度相对iPhone6屏幕宽度的比例
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
@implementation CCShareCustom

static id _publishContent;//类方法中的全局变量这样用（类型前面加static）
static id _ids;
static id _type;
static int _isCollection;
static id _memberID;
static int _loginSuccess;
static id _button;
/*
 自定义的分享类，使用的是类方法，其他地方只要 构造分享内容publishContent就行了
 */

+(void)idString:(NSString *)ids{
    _ids=ids;
    
}
+(void)String:(NSString *)type{
    _type=type;
}
+(void)shareWithContent:(id)publishContent/*只需要在分享按钮事件中 构建好分享内容publishContent传过来就好了*/
{
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    _memberID=[dicsLogid objectForKey:@"sessionID"];
    
    
   
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"collection"];
    NSString *sss=[dic objectForKey:@"isCollection"];
    
    _publishContent = publishContent;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackView.backgroundColor = [UIColor colorWithHexString:@"#3f3f3f" alpha:0.5];
    blackView.alpha=0.5;
    blackView.tag = 440;
    [window addSubview:blackView];
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2.0f, ScreenWidth, kScreenHeight/2.0f)];
    shareView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    shareView.tag = 441;
    [window addSubview:shareView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shareView.width, 45*KWidth_Scale)];
    titleLabel.text = @"分享至";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17*KWidth_Scale];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [shareView addSubview:titleLabel];
    
    NSArray *btnImages = @[@"fenxiang_weixin.png", @"fenxiang_pengyouquan.png", @"fenxiang_qq.png", @"fenxiang_qqzone.png"];
    NSArray *btnTitles = @[@"微信好友", @"微信朋友圈", @"QQ好友", @"QQ空间"];
    for (NSInteger i=0; i<4; i++) {
        CGFloat top = 0.0f;
        if (i<4) {
            top = 10*KWidth_Scale;
            
        }else{
            top = 90*KWidth_Scale;
        }
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/4*i, titleLabel.bottom+top, kScreenWidth/4.0f, kScreenWidth/4.0f)];
        [button setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        [button setTitle:btnTitles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11*KWidth_Scale];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 15*KWidth_Scale, 30*KWidth_Scale, 15*KWidth_Scale)];
        if (SYSTEM_VERSION >= 8.0f) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(75*KWidth_Scale, -62*KWidth_Scale, 5*KWidth_Scale, 5*KWidth_Scale)];
        }else{
            [button setTitleEdgeInsets:UIEdgeInsetsMake(45*KWidth_Scale, -90*KWidth_Scale, 5*KWidth_Scale, 0)];
        }
        
        button.tag = 331+i;
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:button];
    }
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, shareView.height/2.0f, shareView.width, 1)];
    line1.backgroundColor=[UIColor colorWithHexString:@"#e4e4e4"];
    [shareView addSubview:line1];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, shareView.height/2.0f+kScreenWidth/4.0f+26*KWidth_Scale, shareView.width, 1)];
    line2.backgroundColor=[UIColor colorWithHexString:@"#e4e4e4"];
    [shareView addSubview:line2];
    
    UIButton *like = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenWidth/2.0f, kScreenWidth/4.0f, kScreenWidth/4.0f)];
    _button=like;
    _isCollection=sss.intValue;
    if (_isCollection==0) {
        [like setImage:[UIImage imageNamed:@"fenxiang_shoucang_nor"] forState:UIControlStateNormal];
        [like setTitle:@"收藏" forState:UIControlStateNormal];
        like.titleLabel.font = [UIFont systemFontOfSize:11*KWidth_Scale];
    }if (_isCollection==1) {
        [like setImage:[UIImage imageNamed:@"fenxiang_shoucang_pre"] forState:UIControlStateNormal];
        [like setTitle:@"已收藏" forState:UIControlStateNormal];
        
    }
    like.titleLabel.font = [UIFont systemFontOfSize:11*KWidth_Scale];
    
    like.titleLabel.textAlignment = NSTextAlignmentCenter;
    [like setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [like setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [like setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [like setImageEdgeInsets:UIEdgeInsetsMake(0, 15*KWidth_Scale, 30*KWidth_Scale, 15*KWidth_Scale)];
    
        [like setTitleEdgeInsets:UIEdgeInsetsMake(75*KWidth_Scale, -62*KWidth_Scale, 5*KWidth_Scale, 5*KWidth_Scale)];
   
    
    like.tag = 2005;
    [like addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:like];
    
    
    
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, shareView.height-28*KWidth_Scale-8*KWidth_Scale, shareView.width, 30*KWidth_Scale)];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"#3f3f3f"] forState:UIControlStateNormal];
    cancleBtn.tag = 339;
    [cancleBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:cancleBtn];
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
    blackView.alpha = 0;
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1, 1);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
+(void)likeAction:(UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"收藏"]) {
#pragma  mark -用于判断用户是否退出
        NSDictionary *dicsLogOut=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
        NSString*loginOutSuccess=[dicsLogOut objectForKey:@"successful"];
        _loginSuccess=loginOutSuccess.intValue;
        if (_loginSuccess==0) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIView *blackView = [window viewWithTag:440];
            UIView *shareView = [window viewWithTag:441];
            
            //为了弹窗不那么生硬，这里加了个简单的动画
            shareView.transform = CGAffineTransformMakeScale(1, 1);
            [UIView animateWithDuration:0.35f animations:^{
                shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
                blackView.alpha = 0;
            } completion:^(BOOL finished) {
                
                [shareView removeFromSuperview];
                [blackView removeFromSuperview];
                
            }];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert ];
            
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
                UIViewController *root=[[[UIApplication sharedApplication]keyWindow]rootViewController];
                [root presentViewController:viewCon animated:YES completion:nil];
                
            }]];
            //按钮：取消，类型：UIAlertActionStyleCancel
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            UIViewController *root=[[[UIApplication sharedApplication]keyWindow]rootViewController];
            [root presentViewController:alertController animated:YES completion:nil];
            
        }else if (_loginSuccess==1){
            [btn setImage:[UIImage imageNamed:@"fenxiang_shoucang_pre"] forState:UIControlStateSelected];
            [btn setTitle:@"已收藏" forState:UIControlStateNormal];
            
            NSLog(@"收藏成功");
            NSURL *URL = [NSURL URLWithString:KURL];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [ AFHTTPRequestSerializer serializer ];
            manager.responseSerializer =[ AFHTTPResponseSerializer serializer ];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" :@"member.collection.add",@"appKey" :@"w4q897jgvxkb",@"v" :@"1.0", @"format" : @"json",@"sessionId": [NSString stringWithFormat:@"%@",_memberID], @"id" : [NSString stringWithFormat:@"%@",_ids]}];
            [manager POST:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
                
                _isCollection=1;
                
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                
            }];
#pragma mark - //实验
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                NSString*urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_ids,_memberID];
                
                AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
                manager2.requestSerializer = [AFJSONRequestSerializer serializer];
                manager2.responseSerializer =[AFJSONResponseSerializer serializer];
                manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
                [manager2 GET:urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//                    NSLog(@"请求成功跳转详情%@",responseObject);
                    
                    
                    
                    [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
                    
                    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"collection"];
                    NSString *sss=[dic objectForKey:@"isCollection"];
                    _isCollection=sss.intValue;
                    
                    
                } failure:^(NSURLSessionTask *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    
                }];
            });
            
            
            
#pragma mark - //分割线
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIView *blackView = [window viewWithTag:440];
            UIView *shareView = [window viewWithTag:441];
            
            //为了弹窗不那么生硬，这里加了个简单的动画
            shareView.transform = CGAffineTransformMakeScale(1, 1);
            [UIView animateWithDuration:0.35f animations:^{
                shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
                blackView.alpha = 0;
            } completion:^(BOOL finished) {
                
                [shareView removeFromSuperview];
                [blackView removeFromSuperview];
                
            }];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功，您可以在我的->收藏里查看" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
#pragma mark - //取消收藏
    }else if ([btn.titleLabel.text isEqualToString:@"已收藏"]){
        
        
        [btn setImage:[UIImage imageNamed:@"fenxiang_shoucang_nor"] forState:UIControlStateSelected];
        [btn setTitle:@"收藏" forState:UIControlStateNormal];
        
        NSLog(@"取消收藏成功");
        
        NSURL *URL = [NSURL URLWithString:KURL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
 
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.collection.del", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json",@"id": [NSString stringWithFormat:@"%@",_ids],@"sessionId": [NSString stringWithFormat:@"%@",_memberID]}];
        [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
            
            
            //NSLog(@"退出登录成功返回数据－%@",responseObject);
 
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
        

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            NSString*urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_ids,_memberID];
            
            AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
            manager2.requestSerializer = [AFJSONRequestSerializer serializer];
            manager2.responseSerializer =[AFJSONResponseSerializer serializer];
            manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
            [manager2 GET:urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//                NSLog(@"请求成功跳转详情%@",responseObject);
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
                
                NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"collection"];
                NSString *sss=[dic objectForKey:@"isCollection"];
                _isCollection=sss.intValue;
               
                
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                
            }];
        });
        
        
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *blackView = [window viewWithTag:440];
        UIView *shareView = [window viewWithTag:441];
        
        //为了弹窗不那么生硬，这里加了个简单的动画
        shareView.transform = CGAffineTransformMakeScale(1, 1);
        [UIView animateWithDuration:0.35f animations:^{
            shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
            blackView.alpha = 0;
        } completion:^(BOOL finished) {
            
            [shareView removeFromSuperview];
            [blackView removeFromSuperview];
            
        }];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
   

    
}
+(void)shareBtnClick:(UIButton *)btn
{
    //    NSLog(@"%@",[ShareSDK version]);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
        blackView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
    }];
    
    int shareType = 0;
    id publishContent = _publishContent;
    switch (btn.tag) {
        case 331:
        {
            shareType = SSDKPlatformSubTypeWechatSession;
        }
            break;
            
        case 332:
        {
            shareType = SSDKPlatformSubTypeWechatTimeline;
        }
            break;
            
        case 333:
        {
            shareType = SSDKPlatformTypeQQ;
        }
            break;
            
        case 334:
        {
            shareType = SSDKPlatformSubTypeQZone;
        }
            break;
            
                case 339:
        {
            return;
        }
            break;
        
            
        default:
            break;
    }
    
    /*
     调用shareSDK的无UI分享类型，
     链接地址：http://bbs.mob.com/forum.php?mod=viewthread&tid=110&extra=page%3D1%26filter%3Dtypeid%26typeid%3D34
     */
    
   
    [ShareSDK share:shareType //传入分享的平台类型
         parameters:publishContent
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
     }];
    
}


@end