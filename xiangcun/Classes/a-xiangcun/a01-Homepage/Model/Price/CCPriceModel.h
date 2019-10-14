//
//  CCPriceModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/10/10.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  tvPricePass false array[object] 价格通信息
 id true string ID
 productName false string 品名
 productSource true string 来源
 highestPrice true string 最高价
 minimumPrice true string 最低价
 tradePrice true string 批发价
 createDateStr true string 发布日期(yyyy-MM-dd HH:mm:ss)
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
@interface CCPriceModel : NSObject
@property (nonatomic,copy)NSString *productName;
@property (nonatomic,copy)NSString *productSource;
@property (nonatomic,copy)NSString *highestPrice;
@property (nonatomic,copy)NSString *minimumPrice;
@property (nonatomic,copy)NSString *tradePrice;
@property (nonatomic,copy)NSString *ids;
@property (nonatomic,copy)NSString *createDateStr;
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
