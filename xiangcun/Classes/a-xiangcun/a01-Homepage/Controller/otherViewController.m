//
//  otherViewController.m
//  LGDeckViewController
//
//  Created by huangzhenyu on 15/6/1.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "otherViewController.h"

@interface otherViewController ()

@end

@implementation otherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor brownColor];
#pragma mark - 代替展示
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight-44.0/667.0*ScreenHeight)];
    bgImage.image=[UIImage imageNamed:@"zhengzaijianshe"];
    [self.view addSubview:bgImage];
    
   // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"zhengzaijianshe"]]];
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
