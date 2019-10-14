//
//  CCSecListModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/30.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCSecListModel : NSObject
//-----更多动态列表详情信息
@property (nonatomic,copy)NSString *ids;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *descriptions;
@property (nonatomic,copy)NSString *thumbnail;//资讯视屏链接
@property (nonatomic,copy)NSString *content;//资讯内容
@property (nonatomic,copy)NSString *copyfrom;//资讯来源
@property (nonatomic,copy)NSString *createDateStr;//发布日期
@property (nonatomic,copy)NSString *video;
@end
