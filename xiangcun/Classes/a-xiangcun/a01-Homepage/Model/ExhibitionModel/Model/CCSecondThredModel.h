//
//  CCSecondThredModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/27.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  article false array[object] 资讯列表信息
 id true string ID
 title false string 标题
 image true string 图片地址
 description true string 简介
 page true object 分页信息
 pageNo true number 当前页
 count true number 总数
 first true number 第一页
 last true number 最后一页
 prev true number 上一页
 next true number 下一页
 firstPage true boolean 是否第一页
 lastPage true boolean 是否最后一页
  新动向更多动态列表信息
 */
@interface CCSecondThredModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *descriptions;
@property (nonatomic,copy)NSString *ids;
@property (nonatomic,copy)NSString *createDateStr;
@property (nonatomic,copy)NSString *recomLevel;
@property (nonatomic,copy)NSString *video;
@property (nonatomic,copy)NSString *page;//分页信息
@property (nonatomic,assign)NSNumber *pageNo;// 当前页
@property (nonatomic,assign)NSNumber *count;//总数
@property (nonatomic,assign)NSNumber *first;//第一页
@property (nonatomic,assign)NSNumber *last;//最后一页
@property (nonatomic,assign)NSNumber *prev;//上一页
@property (nonatomic,assign)NSNumber *next;//下一页
@property (nonatomic,assign)BOOL *firstPage;//是否是第一页
@property (nonatomic,assign)BOOL *lastPage;//是否是最后一页



@end
