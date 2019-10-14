//
//  CCInformationModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/8.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 新动向首页的信息
 *  id true string ID
 title false string 标题
 image true string 图片地址
 description true string 简介
 createDateStr true string 发布日期
 video false string 视频地址
 */
@interface CCInformationModel : NSObject

@property (nonatomic,copy)NSString *ids;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSString *createDateStr;
@property (nonatomic, strong) NSString *video;


@end
