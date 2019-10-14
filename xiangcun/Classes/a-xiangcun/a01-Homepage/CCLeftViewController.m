//
//  CCLeftViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/20.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCLeftViewController.h"
#import "CCNewTrendViewController.h"
#import "CCClassroomViewController.h"
#import "CCPriceViewController.h"
#import "CCRichViewController.h"
#import "CCFarmTourViewController.h"
#import "CCNewFarmerViewController.h"
#import "CCMicroFilmViewController.h"
#import "CCExhibitionViewController.h"
#import "CCBaseNavViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "CCLeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "CCPresentViewController.h"
#import "CCMineViewController.h"
#import "CCAllSearch.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "CCLoginViewController.h"

@interface CCLeftViewController ()<UITextFieldDelegate>
{
    NSArray *_norImageName;
    NSArray *_preImageName;
    NSArray *_buttonName;
    UIImageView *_line;
    UIImageView *_picture;
    NSMutableArray *_controllers;
    NSInteger _count;
    NSInteger _login;
    NSString *_nickNames;
    NSInteger _namesuccess;
    NSInteger _loginOutSuccess;
}
@property (nonatomic,strong)UITextField *myText;
@property (nonatomic,strong)UIImageView *myImage;
@property (nonatomic,strong)UILabel *mynickName;
@end
@implementation CCLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
#pragma mark - 判断是否登录
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
    NSString*count=[dic objectForKey:@"successful"];
    _count=count.integerValue;
    
    NSDictionary *namedicss=[[NSUserDefaults standardUserDefaults]objectForKey:@"userNickName"];
    NSString*namesuccess=[namedicss objectForKey:@"successful"];
    _namesuccess=namesuccess.integerValue;
   
    NSDictionary *memberDic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginOutDic"];
    NSString*loginOutSuccess=[memberDic objectForKey:@"successful"];
    _loginOutSuccess=loginOutSuccess.integerValue;
    [self setBsaeView];
    [self setButton];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self removeFromParentViewController];
    self.myText.text=nil;
//--------------------------------------------------------------
#pragma mark - 判断是否登录
    NSDictionary *memberDic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginOutDic"];
    NSString*loginOutSuccess=[memberDic objectForKey:@"successful"];
    _loginOutSuccess=loginOutSuccess.integerValue;
    NSDictionary *dicss=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
    NSString*count=[dicss objectForKey:@"successful"];
    _count=count.integerValue;

    NSDictionary *dic2=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *str1=[dic2 objectForKey:@"successful"];
    _login=str1.integerValue;
    
    if (_loginOutSuccess==0) {
        if (_count==1&&_login==1) {
            NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
            NSString *imageURL=[dics objectForKey:@"headPortrait"];
            
            
            [self.myImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
        }else if (_count==0&&_login==1){
            
            NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
            NSString *imageURL=[dics objectForKey:@"headPortrait"];
            
            [self.myImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
            
        }if (_namesuccess==0) {
            NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
            _nickNames=[dics objectForKey:@"nickName"];
            self.mynickName.text=_nickNames;
        }else if (_namesuccess==1){
            
            NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"localName"];
            _nickNames=[dics objectForKey:@"name"];
            self.mynickName.text=_nickNames;
           
        }
        //self.mynickName.text=_nickNames;
        
    } if (_loginOutSuccess==1){
        self.myImage.image=[UIImage imageNamed:@"log"];
        self.mynickName.text=@"爱农易";
       
    }
   // NSLog(@"_loginOutSuccess==%@",_loginOutSuccess?@"YES":@"NO");
   

    
    
}


-(void)setBsaeView{
    
    UIImageView *userImage=[[UIImageView alloc]initWithFrame:CGRectMake(82.0/360.0*ScreenWidth, 63.0/667.0*ScreenHeight, 90.0/360.0*ScreenWidth, 90.0/360.0*ScreenWidth)];
    self.myImage=userImage;
    
    userImage.userInteractionEnabled=YES;
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=45.0/360.0*ScreenWidth;
    userImage.layer.borderWidth=2;
    userImage.layer.borderColor=[UIColor whiteColor].CGColor;
    [self.view addSubview:userImage];
    UIButton *jumpButton=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 90.0/360.0*ScreenWidth, 90.0/667.0*ScreenHeight)];
    
        //---------
        if (_loginOutSuccess==0) {
            if (_count==1) {
                NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
                NSString *imageURL=[dics objectForKey:@"headPortrait"];
                
                [self.myImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"log"]];
            }else if (_count==0){
                
                NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
                NSString *imageURL=[dics objectForKey:@"headPortrait"];
                
                [self.myImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"log"]];
                
            }
            
            
        } if (_loginOutSuccess==1){
            self.myImage.image=[UIImage imageNamed:@"log"];
            
           // [jumpButton addTarget:self action:@selector(jumpLogin) forControlEvents:UIControlEventTouchUpInside];
        }

        //----------
    [jumpButton addTarget:self  action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
        
   
    jumpButton.backgroundColor=[UIColor clearColor];
    
    
    
    [userImage addSubview:jumpButton];
    
    
    UILabel *userName=[[UILabel alloc]initWithFrame:CGRectMake(73.0/360.0*ScreenWidth, 160.0/663.0*ScreenHeight, 110.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    userName.textAlignment=NSTextAlignmentCenter;
    userName.text=@"爱农易";
    self.mynickName=userName;
    if (_namesuccess==0) {
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
        _nickNames=[dics objectForKey:@"nickName"];
        self.mynickName.text=_nickNames;
    }else if (_namesuccess==0){
        
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"localName"];
        _nickNames=[dics objectForKey:@"name"];
        self.mynickName.text=_nickNames;
    }

    userName.textColor=[UIColor colorWithHexString:@"#ffffff"];
    userName.font=[UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    
    userName.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:userName];
    
    UITextField *searchText=[[UITextField alloc]initWithFrame:CGRectMake(40.0/360.0*ScreenWidth, 200.0/667.0*ScreenHeight, 183.0/360.0*ScreenWidth, 29.0/667.0*ScreenHeight)];
    searchText.userInteractionEnabled=YES;
    searchText.placeholder=@"新农人";
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(0.0, 16.0/667.0*ScreenHeight, 10.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    left.backgroundColor=[UIColor clearColor];
    searchText.leftView=left;
    searchText.leftViewMode=UITextFieldViewModeAlways;
    self.myText=searchText;
    [searchText setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
    [searchText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchText.background=[UIImage imageNamed:@"kuaijie_input"];
    searchText.returnKeyType=UIReturnKeySearch;
    searchText.delegate=self;
    [self.view addSubview:searchText];
    UIButton *search=[[UIButton alloc]initWithFrame:CGRectMake(190.0/360.0*ScreenWidth, 190.0/667.0*ScreenHeight, 50.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];
    search.backgroundColor=[UIColor clearColor];
    [self.view addSubview:search];
     [search addTarget:self action:@selector(searchInfor) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *searchButton=[[UIButton alloc]initWithFrame:CGRectMake(155.0/360.0*ScreenWidth, 8.0/667.0*ScreenHeight, 15.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
   
    [searchButton setBackgroundImage:[UIImage imageNamed:@"kuaijie_sousuo"] forState:UIControlStateNormal];
    [searchText addSubview:searchButton];
    
    
    
}

-(void)searchInfor{
    if ([self.myText.text length]<=0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }else{
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.myText.text] forKey:@"searchwords"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"searchword"];
        
        
        
        
        UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCAllSearch" bundle:nil] instantiateInitialViewController];
        [self presentViewController:SecondController animated:YES completion:nil];
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.myText.text length]<=0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else{
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.myText.text] forKey:@"searchwords"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"searchword"];
        
        
        
        
        UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCAllSearch" bundle:nil] instantiateInitialViewController];
        [self presentViewController:SecondController animated:YES completion:nil];
        
    }
    return YES;
}

-(void)jump{
    CCMineViewController *mine=[[CCMineViewController alloc]init];
    CCBaseNavViewController *navi1 = [[CCBaseNavViewController alloc] initWithRootViewController:mine];
    [self presentViewController:navi1 animated:YES completion:NULL];
    
}
-(void)jumpLogin{
    
    CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
    [self presentViewController:viewCon animated:YES completion:nil];
}

-(void)setButton{
    _norImageName=@[@"btn_xdx_nor",@"btn_dkt_nor",@"btn_jgt_nor",@"btn_zfj_nor",@"btn_njy_nor",@"btn_xcms_nor",@"btn_xnr_nor",@"btn_nzg_nor"];
    _preImageName=@[@"btn_xdx_pre",@"btn_dkt_pre",@"btn_jgt_pre",@"btn_zfj_pre",@"btn_njy_pre",@"btn_xcms_pre",@"btn_xnr_pre",@"btn_nzg_pre"];
    
        _buttonName=@[@"新动向",@"大课堂",@"价格通",@"致富经",@"农家游",@"乡村美味",@"新农人",@"农展馆"];
    
   
    
    for (int index=0; index<8; index++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 229.0/667.0*ScreenHeight+42.0/667.0*ScreenHeight*index, ScreenWidth, 42.0/667.0*ScreenHeight)];
        button.tag=1000+index;
//        _line=[[UIImageView alloc]initWithFrame:CGRectMake(64, 41, 120, 1)];
//        _line.image=[UIImage imageNamed:@"kuaijie_line_hengxian"];
//        [button addSubview:_line];
         _picture=[[UIImageView alloc]initWithFrame:CGRectMake(82.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
        _picture.image=[UIImage imageNamed:_norImageName[index]];
        
        UILabel *nameLable=[[UILabel alloc]initWithFrame:CGRectMake(122.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight, 60.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
        nameLable.text=_buttonName[index];
        [nameLable setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
        nameLable.textColor=[UIColor colorWithHexString:@"#ffffff"];
        
        [button addSubview:nameLable];
        [button addSubview:_picture];
        
//-----添加按钮点击事件
        [button addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    
    }
    
    for (int index=0; index<7; index++) {
        _line=[[UIImageView alloc]initWithFrame:CGRectMake(64.0/360.0*ScreenWidth, 272.3/667.0*ScreenHeight+42.0/667.0*ScreenHeight*index, 120.0/360.0*ScreenWidth, 1.0/667.0*ScreenHeight)];
        _line.image=[UIImage imageNamed:@"kuaijie_line_hengxian"];
        [self.view addSubview:_line];
    
    
    
    
    }

    _controllers = [NSMutableArray array];
    
    for (int i =0; i<8; i++) {
        CCPresentViewController *ccvc=[[CCPresentViewController alloc]init];
        CCBaseNavViewController *navi = [[CCBaseNavViewController alloc] initWithRootViewController:ccvc];
        
        //navi.titleStr=arr[i];
        
        ccvc.vcTags=i;
        [_controllers addObject:navi];
    
    }
}
    

-(void)buttonActions:(UIButton *)button{
    NSInteger tag=button.tag-1000;
    
    [self presentViewController:_controllers[tag] animated:YES completion:nil];
    
    
//NSLog(@"点击了第%ld",(long)tag);
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
