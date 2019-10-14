//
//  CCBaseNavViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/21.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCBaseNavViewController.h"
#import "UINavigationBar+Extension.h"
#import "MMDrawerBarButtonItem.h"
#import "CCLeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIBarButtonItem+Item.h"
@interface CCBaseNavViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation CCBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
     self.delegate = self;
     self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setNavBarBackgroudColor:[CCAppSeting shareInstance].appMainColor withAlpha:1.0f];
         self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [CCAppSeting shareInstance].titleColor, NSFontAttributeName : [UIFont systemFontOfSize:18.0f]};
    [self.navigationBar setNavBarShadowColor:[UIColor colorWithHexString:kGlobalSeparatorColorStr] withAlpha:1.0f];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"nav_back"  highImage:@"nav_back" target:self action:@selector(OnSearch) forControlEvents:UIControlEventTouchUpInside];
    if (self.pushing == YES) {
       // NSLog(@"被拦截");
        return;
    } else {
       // NSLog(@"push");
        self.pushing = YES;
    }
    [super pushViewController:viewController animated:animated];
}
//-(void)OnSearch{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
}

//手势代理方法
#pragma mark - <UIGestureRecognizerDelegate>
// 决定是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 0;
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
