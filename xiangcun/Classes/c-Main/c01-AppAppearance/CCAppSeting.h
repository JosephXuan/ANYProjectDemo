//
//  CCAppSeting.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CCAppSeting : NSObject
@property (copy, nonatomic) UIColor *appMainColor;
@property (nonatomic,strong, readonly) UIColor *titleColor;

+ (instancetype)shareInstance;
- (UIFont *)systemBoldFontWithSize:(CGFloat)size;

@end
