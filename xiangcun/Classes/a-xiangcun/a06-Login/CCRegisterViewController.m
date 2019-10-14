//
//  CCRegisterViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/17.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCRegisterViewController.h"
#import "BoolDecide.h"
#import "AFNetworking.h"
#import "MJExtension.h"
@interface CCRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *userNameTf;

@property (nonatomic,strong) UITextField *pswTf;
@end

@implementation CCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    [self setBaseView];
}
-(void)setBaseView{
#pragma mark --临时返回按钮
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#"]];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    UIImageView *logImage=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-126.0/360.0*ScreenWidth)/2, 86.0/667.0*ScreenHeight, 126.0/360.0*ScreenWidth, 126.0/667.0*ScreenHeight)];
    logImage.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:logImage];
    
    UITextField *userName=[[UITextField alloc]initWithFrame:CGRectMake((ScreenWidth-275.0/360.0*ScreenWidth)/2, 263.0/667.0*ScreenHeight, 275.0/360.0*ScreenWidth, 51.0/667.0*ScreenHeight)];
    userName.layer.cornerRadius=25.5/360.0*ScreenWidth;
    userName.layer.masksToBounds=YES;
    userName.layer.borderWidth=1;
    userName.layer.borderColor=[UIColor whiteColor].CGColor;
    userName.placeholder=@"请输入帐号";
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
    self.userNameTf=userName;
    userName.leftViewMode=UITextFieldViewModeAlways;
    [userName addSubview:line];
    [self.view addSubview:userName];
    
    
    UIView *left2 = [[UIView alloc]initWithFrame:CGRectMake(0.0, 16.0/667.0*ScreenHeight, 65.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    left.backgroundColor=[UIColor clearColor];
    
    UITextField *passWord=[[UITextField alloc]initWithFrame:CGRectMake((ScreenWidth-275.0/360.0*ScreenWidth)/2, 263.0/667.0*ScreenHeight+69.0/667.0*ScreenHeight, 275.0/360.0*ScreenWidth, 51.0/667.0*ScreenHeight)];
    passWord.placeholder=@"请输入密码";
    passWord.textColor=[UIColor whiteColor];
    passWord.layer.cornerRadius=25.5/360.0*ScreenWidth;
    passWord.layer.masksToBounds=YES;
    passWord.layer.borderWidth=1;
    passWord.layer.borderColor=[UIColor whiteColor].CGColor;
    passWord.delegate=self;
    self.pswTf=passWord;
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
    
    UIButton *loginButton=[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-275.0/360.0*ScreenWidth)/2, 263.0/667.0*ScreenHeight+69.0/667.0*ScreenHeight+69.0/667.0*ScreenHeight, 275.0/360.0*ScreenWidth, 51.0/667.0*ScreenHeight)];
    loginButton.layer.cornerRadius=25.5/360.0*ScreenWidth;
    loginButton.layer.masksToBounds=YES;
    loginButton.backgroundColor=[UIColor colorWithHexString:@"#f5c931"];
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];

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
        
    }
    
    //  判断密码
    
    if (!([self.pswTf.text length]<=30 && [self.pswTf.text length]>=6)) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }

    
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.userNameTf.text] forKey:@"name"];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"userName"];
    
    NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.pswTf.text] forKey:@"pass"];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic2 forKey:@"pasWord"];
    [self sendRequest];
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功，请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

/**
 *  method true string 方法 member.regist
 appKey true string w4q897jgvxkb
 v true string 版本号 1.0
 format true string 数据格式 json
 account false string 登录账号
 password false string 密码
 registSource false string 来源（2：android,3:ios）
 */

-(void)sendRequest{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.regist", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0",@"registSource" : @"3", @"format" : @"json",@"account": [NSString stringWithFormat:@"%@",self.userNameTf.text], @"password" : [NSString stringWithFormat:@"%@",self.pswTf.text]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
        // NSArray *article = responseObject[@""];
          NSLog(@"注册成功返回数据－%@",responseObject);
        
        
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"zhuceDic"];
        
        
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
