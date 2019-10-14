//
//  CCAppSeting.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCAppSeting.h"

@implementation CCAppSeting
+ (instancetype)shareInstance
{
    static CCAppSeting *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (UIColor *)appMainColor {
    return CCColor(31, 172, 63);
}
- (UIColor *)titleColor {
    return CCColorString(@"#ffffff");
}
- (UIFont *)systemBoldFontWithSize:(CGFloat)size {
    return [UIFont systemFontOfSize:18.f];
}
@end
