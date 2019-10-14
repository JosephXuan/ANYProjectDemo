//
//  CCMineViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCMineViewController.h"
#import "CCMineModel.h"
#import "CCMineTableViewCell.h"
#import "CCLoginViewController.h"
#import "CCChangeInforViewController.h"
#import "CCBaseNavViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "CCAdDetailViewController.h"
#import "CCMyMessageViewController.h"
#import "CCBaseNavViewController.h"
#import "CCCollectionViewController.h"
@interface CCMineViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _count;
    NSInteger _login;
    NSInteger _loginOutSuccess;
    UIButton * _logButton;
}
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CCMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = CCColorString(@"#f4f4f4");
#pragma mark - 判断是否登录
    NSDictionary *dic2=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *str1=[dic2 objectForKey:@"successful"];
    _login=str1.integerValue;
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
    NSString *str2=[dic objectForKey:@"successful"];
    _count=str2.integerValue;
    NSDictionary *memberDic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginOutDic"];
    NSString *str3=[memberDic objectForKey:@"successful"];
    _loginOutSuccess=str3.integerValue;
    
    
    [self setUpAboveView];
    [self addTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    
#pragma mark - 判断是否登录
    NSDictionary *dic2=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *str1=[dic2 objectForKey:@"successful"];
    _login=str1.integerValue;
    
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
    NSString *str2=[dic objectForKey:@"successful"];
    _count=str2.integerValue;
    NSDictionary *memberDic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginOutDic"];
    NSString *str3=[memberDic objectForKey:@"successful"];
    _loginOutSuccess=str3.integerValue;
    
    
    
    if (_loginOutSuccess==0) {
        if (_count==1&&_login==1) {
            NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
            NSString *imageURL=[dics objectForKey:@"headPortrait"];
            
            UIImageView *images=[[UIImageView alloc]init];
            [images sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"log"]];
            UIImage *img=images.image;
            [_logButton setBackgroundImage:img forState:UIControlStateNormal];
        }else if (_count==0&&_login==1){
            
            NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
            NSString *imageURL=[dics objectForKey:@"headPortrait"];
            
            UIImageView *images=[[UIImageView alloc]init];
            [images sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
            UIImage *img=images.image;
            [_logButton setBackgroundImage:img forState:UIControlStateNormal];
  
        }
        
    } if (_loginOutSuccess==1||_login==0){
        [_logButton setBackgroundImage:[UIImage imageNamed:@"log"] forState:UIControlStateNormal];
        
       [_logButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }if (_login==0){
        [_logButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    
    
}


- (void)setUpAboveView {
    UIView *contenview = [[UIView alloc]init];
    contenview.frame = CGRectMake(0.0, 0.0, ScreenWidth, 218.0/667.0*ScreenHeight);
    contenview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenview];
    
    _logButton = [[UIButton alloc]init];
    
    _logButton.tag=2001;
    
            NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
            NSString *imageURL=[dics objectForKey:@"headPortrait"];
            
            UIImageView *images=[[UIImageView alloc]init];
            [images sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"log"]];
            UIImage *img=images.image;
            [_logButton setBackgroundImage:img forState:UIControlStateNormal];
    
            
    
    [contenview addSubview:_logButton];
    [_logButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:contenview withOffset:21];
    [_logButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_logButton autoSetDimensionsToSize:CGSizeMake(100.0/667.0*ScreenHeight, 100.0/667.0*ScreenHeight)];
    _logButton.layer.cornerRadius=50.0/667.0*ScreenHeight;
    _logButton.layer.masksToBounds=YES;
    _logButton.layer.borderWidth=3;
    _logButton.layer.borderColor=[UIColor colorWithHexString:@"#1ab750"].CGColor;
    
    UIButton *commitInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitInfo setTitle:@"修改资料" forState:UIControlStateNormal];
    commitInfo.titleLabel.font = [UIFont systemFontOfSize:14.0/360.0*ScreenWidth];
    [commitInfo setTitleColor:CCColorString(@"#333333") forState:UIControlStateNormal];
    [commitInfo addTarget:self action:@selector(handleButtonAction2) forControlEvents:UIControlEventTouchUpInside];
    [contenview addSubview:commitInfo];
    [commitInfo autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [commitInfo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_logButton withOffset:11];
    [commitInfo setImage:[UIImage imageNamed:@"xiugai"] forState:UIControlStateNormal];
    
    commitInfo.imageEdgeInsets = UIEdgeInsetsMake(0.0, 57.0/667.0*ScreenHeight, 0.0, -52.0/667.0*ScreenHeight);
    commitInfo.titleEdgeInsets = UIEdgeInsetsMake(0.0, -10.0/667.0*ScreenHeight, 0.0, 10.0/667.0*ScreenHeight);
    
    UIView *lineViewOne = [[UIView alloc]init];
    lineViewOne.frame = CGRectMake(0.0, 161.0/667.0*ScreenHeight, ScreenWidth, 1);
    lineViewOne.backgroundColor = CCColor(228, 228, 228);
    [contenview addSubview:lineViewOne];
    
    UIView *lineViewTwo = [[UIView alloc]init];
    lineViewTwo.frame = CGRectMake(ScreenWidth/2, 171.0/667.0*ScreenHeight, 1, 37.0/667.0*ScreenHeight);
    lineViewTwo.backgroundColor = CCColor(228, 228, 228);
    [contenview addSubview:lineViewTwo];
    
//    UIView *lineViewThree = [[UIView alloc]init];
//    lineViewThree.frame = CGRectMake(ScreenWidth * 2/3, 171.0/667.0*ScreenHeight, 1, 37.0/667.0*ScreenHeight);
//    lineViewThree.backgroundColor = CCColor(228, 228, 228);
//    [contenview addSubview:lineViewThree];

    
    
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.frame = CGRectMake(0.0, 161.0/667.0*ScreenHeight, ScreenWidth / 2, 57.0/667.0*ScreenHeight);
    scanButton.tag=2002;
    [scanButton setTitle:@"看过" forState:UIControlStateNormal];
    scanButton.titleLabel.font = [UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    [scanButton setTitleColor:CCColorString(@"#333333") forState:UIControlStateNormal];

    [scanButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contenview addSubview:scanButton];
    
//    UIButton *cacheButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cacheButton.frame = CGRectMake(ScreenWidth / 3, 161.0/667.0*ScreenHeight, ScreenWidth / 3, 57.0/667.0*ScreenHeight);
//    cacheButton.tag=2003;
//    [cacheButton setTitle:@"缓存" forState:UIControlStateNormal];
//    cacheButton.titleLabel.font = [UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
//    [cacheButton setTitleColor:CCColorString(@"#333333") forState:UIControlStateNormal];
//
//    [cacheButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [contenview addSubview:cacheButton];
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(ScreenWidth / 2, 161.0/667.0*ScreenHeight, ScreenWidth / 2, 57.0/667.0*ScreenHeight);
    collectButton.tag=2004;
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:CCColorString(@"#333333") forState:UIControlStateNormal];

    collectButton.titleLabel.font = [UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    [collectButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contenview addSubview:collectButton];
    

    
    
}
- (void)addTableView {
    NSArray *titleArray = @[@"离线缓存",@"历史记录",@"我的消息"];
    NSArray *imageNameArray = @[@"lixian.png",@"lishijilu.png",@"pinglun.png"];
    for (NSUInteger i = 0; i < 3; i ++) {
        CCMineModel *model = [[CCMineModel alloc]init];
        model.titleString = titleArray[i];
        model.imageString = imageNameArray[i];
        [self.dataSource addObject:model];
    }
    
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.backgroundColor = CCColorString(@"#f4f4f4");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 58.0/667.0*ScreenHeight;
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.frame = CGRectMake(0.0, 230.0/667.0*ScreenHeight, ScreenWidth, 230.0/667.0*ScreenHeight);
    [tableView registerClass:[CCMineTableViewCell class] forCellReuseIdentifier:@"CCMineTableViewCell"];
    [self.view addSubview:tableView];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#pragma mark - 跳转离线缓存
    if (indexPath.row==0) {
        if (_login==0) {
           
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert ];
            
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
                [self presentViewController:viewCon animated:YES completion:nil];
                
            }]];
            //按钮：取消，类型：UIAlertActionStyleCancel
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                
                    [self presentViewController:alertController animated:YES completion:nil];
                
                
                
          

            
        }else if (_login==1){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无缓存，快去浏览吧" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            
            
        }
    }

#pragma mark - 跳转历史记录
    if (indexPath.row==1) {
        if (_login==0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert ];
            
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
                [self presentViewController:viewCon animated:YES completion:nil];
                
            }]];
            //按钮：取消，类型：UIAlertActionStyleCancel
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        } if (_login==1){

        UINavigationController *history = [[UIStoryboard storyboardWithName:@"HistorySearchStoryboard" bundle:nil] instantiateInitialViewController];
        [self presentViewController:history animated:YES completion:nil];
        }
    }
//#pragma mark - 跳转我的关注
//    if (indexPath.row==2) {
//        if (_count==0) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录，谢谢！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alertView show];
//            
//        }else if (_count==1){
//            
//           
//        }
//    }
#pragma mark - 跳转我的消息
    if (indexPath.row==2) {
        if (_login==0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert ];
            
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
                [self presentViewController:viewCon animated:YES completion:nil];
                
            }]];
            //按钮：取消，类型：UIAlertActionStyleCancel
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        } if (_login==1){
            CCMyMessageViewController *myMessaga= [[CCMyMessageViewController alloc] init];
            
            myMessaga.title=@"我的消息";
           
            [self.navigationController pushViewController:myMessaga animated:YES];
            
            
      
            
           
        }
    }


}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCMineTableViewCell" forIndexPath:indexPath];
    CCMineModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)handleButtonAction:(UIButton *)button {
    if (button.tag==2001&&_loginOutSuccess==1) {
        CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
        [self presentViewController:viewCon animated:YES completion:nil];
    }else if (button.tag==2001&&_loginOutSuccess==0&&_login==0){
        //NSLog(@"%@",_login);
        CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
        [self presentViewController:viewCon animated:YES completion:nil];
    }if (button.tag==2002) {
        if (_login==0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert ];
            
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
                [self presentViewController:viewCon animated:YES completion:nil];
                
            }]];
            //按钮：取消，类型：UIAlertActionStyleCancel
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        } if (_login==1){
            
            UINavigationController *history = [[UIStoryboard storyboardWithName:@"HistorySearchStoryboard" bundle:nil] instantiateInitialViewController];
            [self presentViewController:history animated:YES completion:nil];
        }

    }if (button.tag==2004) {
        if (_login==0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert ];
            
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                CCLoginViewController *viewCon=[[CCLoginViewController alloc]init];
                [self presentViewController:viewCon animated:YES completion:nil];
                
            }]];
            //按钮：取消，类型：UIAlertActionStyleCancel
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        } if (_login==1){
            
            UINavigationController *history = [[UIStoryboard storyboardWithName:@"CollectionStoryboard" bundle:nil] instantiateInitialViewController];
            [self presentViewController:history animated:YES completion:nil];
        }

    
    }
    
    

}
#pragma mark - //跳转修改资料页面
- (void)handleButtonAction2 {
    if (_login==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录，谢谢！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];

    }
    else if (_login==1){
    
       CCChangeInforViewController *viewCon=[[CCChangeInforViewController alloc]init];
    CCBaseNavViewController *SecondController = [[CCBaseNavViewController alloc]initWithRootViewController:viewCon];
    [self presentViewController:SecondController animated:YES completion:nil];
    }
    
    
    
    
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
