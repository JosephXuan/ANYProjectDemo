//
//  CCHomeTabbarItem.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHomeTabbarItem.h"
#import "CCNavgationController.h"
#import "CCHomepageController.h"
#import "CCLivingViewController.h"
#import "CCColumnViewController.h"
#import "CCMineViewController.h"
#import "CCSetupViewController.h"

#define KHomepageControllerTitle @"首页"
#define KLivingViewControllerTitle @"直播"
#define KColumnViewControllerTitle @"栏目"
#define KMineViewControllerTitle @"我的"
#define KSetupViewControllerTitle @"设置"

@implementation CCHomeTabbarItem

- (instancetype)initWithController:(UIViewController *)controller {
    if (self = [super init]) {
        self.controller = controller;
        NSString *norImageName = nil;
        NSString *selectImageName = nil;
        if ( [controller isKindOfClass:[CCNavgationController class]] )
        {
            CCNavgationController *nav = (CCNavgationController *)controller;
            controller = nav.topViewController;
        }
        if ([controller isKindOfClass:[CCHomepageController class]]) {
            self.title =KHomepageControllerTitle;
            norImageName = @"btn_shouye_nor";
            selectImageName = @"btn_shouye_pre";
        }
        else if ([controller isKindOfClass:[CCLivingViewController class]]) {
            self.title = KLivingViewControllerTitle;
            norImageName = @"btn_zhibo_nor";
            selectImageName = @"btn_zhibo_pre";
        }
        else if ([controller isKindOfClass:[CCColumnViewController class]]) {
            self.title = KColumnViewControllerTitle;
            norImageName = @"btn_lanmu_nor";
            selectImageName = @"btn_lanmu_pre";
        }
        else if ([controller isKindOfClass:[CCMineViewController class]])
        {
            self.title = KMineViewControllerTitle;
            norImageName = @"btn_wode_nor";
            selectImageName = @"btn_wode_pre";
        }else if ([controller isKindOfClass:[CCSetupViewController class]]) {
            self.title = KSetupViewControllerTitle;
            norImageName = @"btn_shezhi_nor";
            selectImageName = @"btn_shezhi_pre";
        }
        UIImage *image = [UIImage imageNamed:norImageName];
        self.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [UIImage imageNamed:selectImageName];
        
        
        self.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        controller.tabBarItem = self;
    }
    return self;
}
/*
 
 - returns: return value description
 */
 + (instancetype)homeTabBarItemWithController:(UIViewController *)controller{
    return [[self alloc] initWithController:controller];
}

@end
