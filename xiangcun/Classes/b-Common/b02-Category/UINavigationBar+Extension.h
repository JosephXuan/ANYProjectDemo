//
//  UINavigationBar+Extension.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Extension)
/**
 *  设置navigationBar背景色
 *
 *  @param color 要设置的颜色
 *  @param alpha navigationBar透明度
 */
- (void)setNavBarBackgroudColor:(UIColor *)color withAlpha:(CGFloat)alpha;

/**
 *  设置navigationBar下面黑线的颜色
 *
 *  @param color 要设置的颜色
 *  @param alpha 透明度
 */
- (void)setNavBarShadowColor:(UIColor *)color withAlpha:(CGFloat)alpha;

@end
