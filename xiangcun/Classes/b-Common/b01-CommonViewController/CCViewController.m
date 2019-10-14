//
//  CCViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/7.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCViewController.h"
#import "UINavigationBar+Extension.h"

@interface CCViewController()< UIGestureRecognizerDelegate>

@end

@implementation CCViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setNavBarBackgroudColor:[UIColor whiteColor] withAlpha:1.0f];
    [self.navigationController.navigationBar setNavBarBackgroudColor:AppMainColor withAlpha:1.0f];
    [self.navigationController.navigationBar setNavBarShadowColor:[UIColor colorWithHexString:kGlobalSeparatorColorStr] withAlpha:1.0f];
    
    // 添加是否是navigationController的rootViewController，如果是，则把左侧返回按钮给替换掉空白view
//   if ( self.navigationController.viewControllers.count <= 1 )
//   {
//        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]]];
//   }
   
     // CCLog(@"--^@^--self.navigationController.viewControllers.count:%@,%ld", NSStringFromClass([self class]), self.navigationController.viewControllers.count);
   // 重新设置代理，防止从pop出来的控制器，导航控制器的手势丢失代理引起crash
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
}
#pragma mark - UIGestureRecogiserDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //    CCLog(@"-*-^@^--self.navigationController.viewControllers.count:%@,%ld", NSStringFromClass([self class]), self.navigationController.viewControllers.count);
    // 导航控制器的子控制器的个数为1时，则不再响应手势
    if ( self.navigationController.viewControllers.count <= 1 )
    {
        return NO;
    }
    
    return YES;
}

@end
