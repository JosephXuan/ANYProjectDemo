//
//  NSObject+Extension.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCHelper.h"
@interface NSObject (Extension)
- (void)performBlockOnMainThread:(void(^)())block;

+ (void)performBlockOnMainThreadInClass:(void(^)())block;

@end
