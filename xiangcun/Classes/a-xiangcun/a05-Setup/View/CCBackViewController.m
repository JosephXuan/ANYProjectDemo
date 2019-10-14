//
//  CCBackViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/28.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCBackViewController.h"
#import "CCLoginViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MyTextView.h"
#import "BoolDecide.h"

@interface CCBackViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    NSInteger _successful;
    NSString *_sessionID;
}
@property (nonatomic,strong)MyTextView *text;

@property (nonatomic,strong)UITextField *phoneNum;



@end

@implementation CCBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CCColorString(@"#f4f4f4");
    self.navigationController.navigationBar.translucent = NO;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0, 0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    
    _sessionID=[dic objectForKey:@"sessionID"];
    NSString *successful=[dic objectForKey:@"successful"];

    _successful=successful.integerValue;
    [self setBaseView];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    
    _sessionID=[dic objectForKey:@"sessionID"];
    NSString *successful=[dic objectForKey:@"successful"];
    
    _successful=successful.integerValue;
}

-(void)setBaseView{
#pragma mark - 这句话是让他的自适应导航栏取消，默认是yes
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, 0.0/667.0*ScreenHeight, ScreenWidth-10.0/360.0*ScreenWidth, ScreenHeight-84.0/667.0*ScreenHeight)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
#pragma mark - 意见输入框
    _text=[[MyTextView alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, ScreenWidth-40.0/360.0*ScreenWidth,130.0/667.0*ScreenHeight)];
    _text.layer.cornerRadius=10.0/360.0*ScreenWidth;
    _text.layer.masksToBounds=YES;
    _text.layer.borderWidth=1;
    _text.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _text.myPlaceholder=@"请输入您的宝贵意见，我们将不断改进";
    [bgView addSubview:_text];
    
#pragma mark - 手机号输入框
    UITextField *phoneNum=[[UITextField alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 150.0/667.0*ScreenHeight, ScreenWidth-40.0/360.0*ScreenWidth,35.0/667.0*ScreenHeight)];
    self.phoneNum=phoneNum;
    phoneNum.layer.cornerRadius=10.0/360.0*ScreenWidth;
    phoneNum.layer.masksToBounds=YES;
    phoneNum.layer.borderWidth=1;
    phoneNum.layer.borderColor=[UIColor lightGrayColor].CGColor;
    phoneNum.placeholder=@"请输入您的手机号";
    phoneNum.delegate=self;
    phoneNum.textColor=[UIColor blackColor];
    [bgView addSubview:phoneNum];
    
#pragma mark - 提交按钮
    UIButton *send=[[UIButton alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 195.0/667.0*ScreenHeight, ScreenWidth-40.0/360.0*ScreenWidth,50.0/667.0*ScreenHeight)];
    send.layer.cornerRadius=10.0/360.0*ScreenWidth;
    send.layer.masksToBounds=YES;
    [send setTitle:@"提交" forState:UIControlStateNormal];
    send.backgroundColor=[UIColor colorWithHexString:@"#f5c931"];
    [send addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:send];
    
    
}

-(void)sendAction{
    if (_successful==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert ];
        
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            
            CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
            [self presentViewController:viewCon animated:YES completion:nil];
            
        }]];
        //按钮：取消，类型：UIAlertActionStyleCancel
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (_successful==1){
        if ([_text.text length]<=0) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的宝贵意见" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            return;
        }
        
        if (![BoolDecide validateMobile:self.phoneNum.text]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            return;
        }else{
            [self sendMassage];
        }
   
    }
    
}

#pragma mark - 发送会员意见请求
-(void)sendMassage{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [ AFHTTPRequestSerializer serializer ];
    manager.responseSerializer =[ AFHTTPResponseSerializer serializer ];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.feedback", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0",@"registSource" : @"3", @"format" : @"json",@"sessionId": [NSString stringWithFormat:@"%@",_sessionID], @"content" : [NSString stringWithFormat:@"%@",_text.text],@"phone" : [NSString stringWithFormat:@"%@",self.phoneNum.text]}];
    [manager POST:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
       
       // NSLog(@"会员意见返回数据－%@",responseObject);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功提交您的宝贵意见，感谢支持" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        self.phoneNum.text=nil;
        _text.text=nil;
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
}



-(void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
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
