//
//  CCHomePageBaseViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHomePageBaseViewController.h"

@implementation CCHomePageBaseViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.viewControllerItem.viewLoadFinish = YES;
    self.view.backgroundColor=[UIColor whiteColor];
//---修改部分***********************************************
   
    _btns = [UIButton buttonWithType:UIButtonTypeSystem];
    _btns.frame = CGRectMake(15.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [_btns setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];

    [_btns setBackgroundColor:[UIColor colorWithHexString:@"#"]];
    [_btns addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    _btns.backgroundColor=[UIColor redColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btns];
   
//
//    
//              [self.navigationController.view addSubview:_btns];
    
  
}
//
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"home走不走");
}
//

- (void)prepareGestureToTarget:(id)tartget withSelector:(SEL)selector
{
    if ( self.gesturePrepared )
    {
        return;
    }
    self.gesturePrepared = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:tartget action:selector];
    [self.view addGestureRecognizer:pan];
}

@end
