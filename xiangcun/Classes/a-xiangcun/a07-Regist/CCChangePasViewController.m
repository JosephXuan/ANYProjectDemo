//
//  CCChangePasViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/11/17.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCChangePasViewController.h"

@interface CCChangePasViewController ()<UITextFieldDelegate>
{
    
}
@property(nonatomic,strong)UITextField *oldPas;

@property(nonatomic,strong)UITextField *newsPas;

@property(nonatomic,strong)UITextField *newsPas2;

@end

@implementation CCChangePasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f4f4f4"];
    [self setBaseView];
}

-(void)setBaseView{
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0.0, 3.0/667.0*ScreenHeight, ScreenWidth, 55.0/667.0*ScreenHeight)];
    view1.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:view1];
    
    
    UIImageView*image1=[[UIImageView alloc]initWithFrame:CGRectMake(15.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-17.0/667.0*ScreenHeight)/2, 13.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    image1.image=[UIImage imageNamed:@"xiugaimima1"];
    [view1 addSubview:image1];
    
    UITextField *oldPasWorld=[[UITextField alloc]initWithFrame:CGRectMake(43.0/360.0*ScreenWidth, 11.0/667.0*ScreenHeight, 100.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
    oldPasWorld.font=[UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    oldPasWorld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.oldPas=oldPasWorld;
    oldPasWorld.placeholder=@"原密码";
    [oldPasWorld setValue:[UIColor colorWithHexString:@"#a1a1a1"] forKeyPath:@"_placeholderLabel.textColor"];
    [oldPasWorld setValue:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    [view1 addSubview:oldPasWorld];
    
  
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0.0, 61.0/667.0*ScreenHeight, ScreenWidth, 55.0/667.0*ScreenHeight)];
    view2.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:view2];
    UIImageView*image2=[[UIImageView alloc]initWithFrame:CGRectMake(15.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-17.0/667.0*ScreenHeight)/2, 13.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    image2.image=[UIImage imageNamed:@"xiugaimima2"];
    [view2 addSubview:image2];
    
    UITextField *newPasWorld=[[UITextField alloc]initWithFrame:CGRectMake(43.0/360.0*ScreenWidth, 11.0/667.0*ScreenHeight, 100.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
    newPasWorld.font=[UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    newPasWorld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.newsPas=newPasWorld;
    newPasWorld.placeholder=@"新密码";
    [newPasWorld setValue:[UIColor colorWithHexString:@"#a1a1a1"] forKeyPath:@"_placeholderLabel.textColor"];
    [newPasWorld setValue:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    [view2 addSubview:newPasWorld];
    
   
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0.0, 119.0/667.0*ScreenHeight, ScreenWidth, 55.0/667.0*ScreenHeight)];
    view3.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:view3];
    UIImageView*image3=[[UIImageView alloc]initWithFrame:CGRectMake(15.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-17.0/667.0*ScreenHeight)/2, 13.0/360.0*ScreenWidth, 17.0/667.0*ScreenHeight)];
    image3.image=[UIImage imageNamed:@"xiugaimima3"];
    [view3 addSubview:image3];
    
    UITextField *newPasWorld2=[[UITextField alloc]initWithFrame:CGRectMake(43.0/360.0*ScreenWidth, 11.0/667.0*ScreenHeight, 100.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
    newPasWorld2.font=[UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    newPasWorld2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.newsPas2=newPasWorld2;
    newPasWorld2.placeholder=@"确认密码";
    [newPasWorld2 setValue:[UIColor colorWithHexString:@"#a1a1a1"] forKeyPath:@"_placeholderLabel.textColor"];
    [newPasWorld2 setValue:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    [view3 addSubview:newPasWorld2];
    
    
    UIButton *changeBtn=[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-222.0/360.0*ScreenWidth)/2, 240.0/667.0*ScreenHeight, 222.0/360.0*ScreenWidth, 60.0/667.0*ScreenHeight)];
    changeBtn.layer.cornerRadius=10.0/360.0*ScreenWidth;
    changeBtn.layer.masksToBounds=YES;
    changeBtn.backgroundColor=CCColorString(@"#1ab750");
    [changeBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [changeBtn setTitleColor:CCColorString(@"#ffffff") forState:UIControlStateNormal];
    [self.view addSubview:changeBtn];
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
