//
//  CCNoticModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/29.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  id true string ID
 title false string 标题
 createDateStr true string 发布日期(yyyy-MM-dd HH:mm:ss)
 href true string 连接
 page true object 分页信息
 pageNo true number 当前页
 count true number 总数
 first true number 第一页
 last true number 最后一页
 prev true number 上一页
 next true number 下一页
 firstPage true boolean 是否第一页
 lastPage true boolean 是否最后一页
公告栏信息
 */
@interface CCNoticModel : NSObject
@property (nonatomic,copy)NSString *ids;//ID
@property (nonatomic,copy)NSString *title;//标题
@property (nonatomic,copy)NSString *createDateStr;//发布日期
@property (nonatomic,copy)NSString *href;//链接
@property (nonatomic,assign)NSNumber *pageNo;// 当前页
@property (nonatomic,assign)NSNumber *count;//总数
@property (nonatomic,assign)NSNumber *first;//第一页
@property (nonatomic,assign)NSNumber *last;//最后一页
@property (nonatomic,assign)NSNumber *prev;//上一页
@property (nonatomic,assign)NSNumber *next;//下一页
@property (nonatomic,assign)BOOL *firstPage;//是否是第一页
@property (nonatomic,assign)BOOL *lastPage;//是否是最后一页@end

@end