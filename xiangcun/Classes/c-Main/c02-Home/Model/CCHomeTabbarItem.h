//
//  CCHomeTabbarItem.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCHomeTabbarItem : UITabBarItem
@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic,weak) UIViewController *sercontr;
- (instancetype)initWithController:(UIViewController *)controller;
+ (instancetype)homeTabBarItemWithController:(UIViewController *)controller;

@end
