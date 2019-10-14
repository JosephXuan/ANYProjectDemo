//
//  CCHistoryModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/28.
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
 */
@interface CCHistoryModel : NSObject

@end
