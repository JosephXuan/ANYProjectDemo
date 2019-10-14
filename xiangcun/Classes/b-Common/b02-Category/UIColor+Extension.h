//
//  UIColor+Extension.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
/**
 *  下面的方法都是使用rgb值得到UIColor对象
 *
 *  @param rgbValue the value of rgb
 *  @param alpha    alpha for the color
 *
 *  @return a color
 */
+ (UIColor *)colorFromRGB:(NSInteger)rgbValue withAlpha:(CGFloat)alpha;
+ (UIColor *)colorFromRGB:(NSInteger)rgbValue;

/**
 *  下面的方法都是使用十六进制字符串得到UIColor对象
 *
 *  @param hexString 十六进制的字符串，比如#ffffff
 *  @param alpha     透明度
 *
 *  @return a color
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexStringWithAlpha:(NSString *)hexString;


@end