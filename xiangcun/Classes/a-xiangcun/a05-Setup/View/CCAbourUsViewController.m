//
//  CCAbourUsViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/28.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCAbourUsViewController.h"

@interface CCAbourUsViewController ()

@end

@implementation CCAbourUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 20, 18);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self setBaseView];
    

}

-(void)setBaseView{
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, ScreenWidth-10.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];
    titleLable.textAlignment=NSTextAlignmentCenter;
    titleLable.font=[UIFont systemFontOfSize:18];
    titleLable.textColor=[UIColor blackColor];
    titleLable.text=@"关于爱农易手机APP";
    [self.view addSubview:titleLable];
    
    UILabel *detailLable=[[UILabel alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, 70.0/667.0*ScreenHeight, ScreenWidth-10.0/360.0*ScreenWidth, 160.0/667.0*ScreenHeight)];
    detailLable.numberOfLines=0;
   
    detailLable.font=[UIFont systemFontOfSize:16];
    detailLable.textColor=[UIColor blackColor];
    detailLable.text=@"    乡村频道视频网站及爱农易手机APP项目开设新动向、大课堂、价格通、农家游、美味江苏、微电影、新农人、农展馆、在线诊断等版块，随时随地为科技示范户、家庭农场主、合作社、农资经销商、农业龙头企业等新型农业经营主体提供农业政策、信息、技术等全方位的服务。";
    [self.view addSubview:detailLable];
    
    
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
