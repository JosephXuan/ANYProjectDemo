//
//  CCLabelsTabbarItem.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCLabelsTabbarItem : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) BOOL viewLoadFinish;

@end
