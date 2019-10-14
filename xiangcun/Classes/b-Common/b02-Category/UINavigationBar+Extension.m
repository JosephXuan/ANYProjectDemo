//
//  UINavigationBar+Extension.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "UINavigationBar+Extension.h"

@implementation UINavigationBar (Extension)
- (void)setNavBarBackgroudColor:(UIColor *)color withAlpha:(CGFloat)alpha {
    UIView *backgroud = [[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, ScreenWidth, 64.0f)];
    backgroud.backgroundColor = color;
    backgroud.alpha = alpha;
    [self setBackgroundImage:[UIImage gp_imageWithView:backgroud]  forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavBarShadowColor:(UIColor *)color withAlpha:(CGFloat)alpha {
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, ScreenWidth, kGlobalSeparatorHeight)];
    shadow.backgroundColor = color;
    shadow.alpha = alpha;
    [self setShadowImage:[UIImage gp_imageWithView:shadow]];
}

@end
