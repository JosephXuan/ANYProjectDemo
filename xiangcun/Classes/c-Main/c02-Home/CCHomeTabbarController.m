//
//  CCHomeTabbarController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHomeTabbarController.h"
#import "CCHomeTabbarItem.h"
@interface CCHomeTabbarController ()
@property (nonatomic, strong) NSArray *items;

@end

@implementation CCHomeTabbarController
+ (instancetype)homeViewControllerWithItems:(NSArray *)items {
    CCHomeTabbarController *controller = [[CCHomeTabbarController alloc]init];
    controller.items = items;
    for (CCHomeTabbarItem *item in items) {
        [controller addChildViewController:item.controller];
    }
    return controller;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [CCAppSeting shareInstance].appMainColor;
   self.tabBar.translucent = NO;
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
