//
//  CCLoginViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/17.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCLoginViewController.h"
#import "CCRegisterViewController.h"
#import "BoolDecide.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"


@interface CCLoginViewController ()<UITextFieldDelegate>
{
    NSInteger _succ;
    
}
@property (nonatomic,strong) UITextField *userNameTf;
@property (nonatomic,strong) UITextField *pswTf;

@end

@implementation CCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    [self setBaseView];
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    
    NSString *count=[dic objectForKey:@"name"];
    self.userNameTf.text=count;
    
    NSDictionary *dic2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pasWord"];
    
    NSString *count2=[dic2 objectForKey:@"pass"];
    self.pswTf.text=count2;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    
    NSString *count=[dic objectForKey:@"name"];
    self.userNameTf.text=count;
    
    NSDictionary *dic2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pasWord"];
    
    NSString *count2=[dic2 objectForKey:@"pass"];
    self.pswTf.text=count2;
    
    
}

-(void)setBaseView{
#pragma mark --临时返回按钮
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    UIImageView *logImage=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-126.0/360.0*ScreenWidth)/2, 86.0/667.0*ScreenHeight, 126.0/360.0*ScreenWidth, 126.0/667.0*ScreenHeight)];
    logImage.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:logImage];
    
    UITextField *userName=[[UITextField alloc]initWithFrame:CGRectMake((ScreenWidth-275.0/360.0*ScreenWidth)/2, 263.0/667.0*ScreenHeight, 275.0/360.0*ScreenWidth, 51.0/667.0*ScreenHeight)];
    self.userNameTf=userName;
    userName.layer.cornerRadius=25.5/360.0*ScreenWidth;
    userName.layer.masksToBounds=YES;
    userName.layer.borderWidth=1;
    userName.layer.borderColor=[UIColor whiteColor].CGColor;
    userName.placeholder=@"账号";
    userName.delegate=self;
   
    userName.textColor=[UIColor whiteColor];
   
    UIImageView *picImage=[[UIImageView alloc]initWithFrame:CGRectMake(17.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight, 16.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    picImage.image=[UIImage imageNamed:@"icon_phone"];
    [userName addSubview:picImage];
    
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(0.0, 16.0/667.0*ScreenHeight, 65.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    left.backgroundColor=[UIColor clearColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(51.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight, 2.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.2;
    userName.leftView=left;
    
    userName.leftViewMode=UITextFieldViewModeAlways;
   [userName addSubview:line];
    [self.view addSubview:userName];
    
    
    UIView *left2 = [[UIView alloc]initWithFrame:CGRectMake(0.0, 16.0/667.0*ScreenHeight, 65.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    left2.backgroundColor=[UIColor clearColor];

    UITextField *passWord=[[UITextField alloc]initWithFrame:CGRectMake((ScreenWidth-275.0/360.0*ScreenWidth)/2, 332.0/667.0*ScreenHeight, 275.0/360.0*ScreenWidth, 51.0/667.0*ScreenHeight)];
    self.pswTf=passWord;
    passWord.placeholder=@"密码";
    passWord.secureTextEntry = YES;
    passWord.textColor=[UIColor whiteColor];
    passWord.layer.cornerRadius=25.5/360.0*ScreenWidth;
    passWord.layer.masksToBounds=YES;
    passWord.layer.borderWidth=1;
    passWord.layer.borderColor=[UIColor whiteColor].CGColor;
    passWord.delegate=self;
    
    
    
    passWord.leftView=left2;
    passWord.leftViewMode=UITextFieldViewModeAlways;
    
   
    UIImageView *picImage2=[[UIImageView alloc]initWithFrame:CGRectMake(17.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight, 16.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    picImage2.image=[UIImage imageNamed:@"icon_suo"];
    [passWord addSubview:picImage2];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(51.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight, 2.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    line2.backgroundColor = [UIColor whiteColor];
    line2.alpha = 0.2;
    [passWord addSubview:line2];
     [self.view addSubview:passWord];
    
    UIButton *loginButton=[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-275.0/360.0*ScreenWidth)/2, 401.0/667.0*ScreenHeight, 275.0/360.0*ScreenWidth, 51.0/667.0*ScreenHeight)];
    loginButton.layer.cornerRadius=25.5/360.0*ScreenWidth;
    loginButton.layer.masksToBounds=YES;
    loginButton.backgroundColor=[UIColor colorWithHexString:@"#f5c931"];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];
  /*
    UIView*FGLine=[[UIView alloc]initWithFrame:CGRectMake(100.0/360.0*ScreenWidth, 508.0/667.0*ScreenHeight, 60.0/360.0*ScreenWidth, 1)];
    FGLine.backgroundColor=[UIColor colorWithWhite:1 alpha:0.8];
    [self.view addSubview:FGLine];
    
    UILabel*FGLable=[[UILabel alloc]initWithFrame:CGRectMake(167.0/360.0*ScreenWidth, 498.0/667.0*ScreenHeight, 25.0/360.0*ScreenWidth, 25.0/360.0*ScreenWidth)];
    FGLable.textColor=[UIColor colorWithHexString:@"#ffffff"];
    FGLable.text=@"或";
    FGLable.font=[UIFont systemFontOfSize:20.0/360.0*ScreenWidth];
    FGLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:FGLable];
    
    UIView*FGLine2=[[UIView alloc]initWithFrame:CGRectMake(200.0/360.0*ScreenWidth, 508.0/667.0*ScreenHeight, 60.0/360.0*ScreenWidth, 1)];
    FGLine2.backgroundColor=[UIColor colorWithWhite:1 alpha:0.8];
    [self.view addSubview:FGLine2];
    
    UIButton*QQLoin=[[UIButton alloc]initWithFrame:CGRectMake(80.0/360.0*ScreenWidth, 548.0/667.0*ScreenHeight, 64.0/360.0*ScreenWidth, 64.0/360.0*ScreenWidth)];
    QQLoin.layer.cornerRadius= 32.0/360.0*ScreenWidth;
    QQLoin.layer.masksToBounds=YES;
    [QQLoin setBackgroundImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
    [QQLoin addTarget:self action:@selector(QQLoins) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQLoin];
    
    
    UIButton*WeiChatLoin=[[UIButton alloc]initWithFrame:CGRectMake(210.0/360.0*ScreenWidth, 548.0/667.0*ScreenHeight, 64.0/360.0*ScreenWidth, 64.0/360.0*ScreenWidth)];
    WeiChatLoin.layer.cornerRadius= 32.0/360.0*ScreenWidth;
    WeiChatLoin.layer.masksToBounds=YES;
    [WeiChatLoin setBackgroundImage:[UIImage imageNamed:@"icon_weixin"] forState:UIControlStateNormal];
    [WeiChatLoin addTarget:self action:@selector(WeiChatLoins) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WeiChatLoin];
    
   */
    
    
    UIButton *zhuce=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-60.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight, 40.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    [zhuce.titleLabel setFont:[UIFont systemFontOfSize:18/360.0*ScreenWidth]];
    [zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhuce addTarget:self action:@selector(zhuceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
    
    
    
}

#pragma mark - //第三方登录
/*
-(void)QQLoins{
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             [self dismissViewControllerAnimated:YES completion:nil];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}
-(void)WeiChatLoins{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             [self dismissViewControllerAnimated:YES completion:nil];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}
 */
-(void)zhuceAction{
    CCRegisterViewController *viewCon=[[CCRegisterViewController alloc]init];
    [self presentViewController:viewCon animated:YES completion:nil];
    
    
}


-(void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}


-(void)loginAction{
    //  先判断用户名密码输入格式
    //  再判断是否注册过
    
    //正则表达式 判断手机号
    
    if (![BoolDecide validateMobile:self.userNameTf.text]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    //  判断密码
    
    if (!([self.pswTf.text length]<=30 && [self.pswTf.text length]>=6)) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.userNameTf.text] forKey:@"name"];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"userName"];
    
    NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.pswTf.text] forKey:@"pass"];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic2 forKey:@"pasWord"];
    
    [self sendRequest];
    
    
    
}



#pragma mark - //登录请求
-(void)sendRequest{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.login", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json",@"account": [NSString stringWithFormat:@"%@",self.userNameTf.text], @"password" : [NSString stringWithFormat:@"%@",self.pswTf.text]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"登录成功返回数据－%@",responseObject);
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginOutDic"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"memberInfor"];
         [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"loginDic"];
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
        NSString *str=[dics objectForKey:@"successful"];
        NSString *error=[dics objectForKey:@"errorMsg"];
        _succ=str.integerValue;
        NSLog(@"%@",error);
        
        if (_succ==NO) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }else if(_succ==YES){
       
             [self requestPersonInfor];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
       
           
        
            
       
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}


-(void)requestPersonInfor{
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    
    NSString *sessionIds=[dic objectForKey:@"sessionID"];
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.query.info", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json",@"sessionId": [NSString stringWithFormat:@"%@",sessionIds]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
       
       // NSLog(@"请求会员信息成功返回数据－%@",responseObject);
        
       
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"personInfor"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
