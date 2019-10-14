//
//  CCDetailModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/29.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  id true number ID
 title true string 标题
 image false string 图片地址
 description true string 资讯简介
 thumbnail false string 资讯视频图片地址
 video false string 资讯视频地址
 content true string 资讯内容
 copyfrom false string 资讯来源
 createDateStr true string 发布日期

 */
@interface CCDetailModel : NSObject

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
