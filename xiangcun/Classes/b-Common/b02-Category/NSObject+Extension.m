//
//  NSObject+Extension.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)
- (void)performBlockOnMainThread:(void(^)())block {
    if ( block == nil )
    {
        return;
    }
    if ( [[NSThread currentThread] isMainThread] )
    {
        block();
        block = nil;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

+ (void)performBlockOnMainThreadInClass:(void (^)())block
{
    if ( block == nil )
    {
        return;
    }
    if ( [[NSThread currentThread] isMainThread] )
    {
        block();
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           block();
                       });
    }
}

@end
