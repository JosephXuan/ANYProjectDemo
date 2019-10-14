//
//  CCAdddModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/22.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCAdddModel : NSObject
/**
 *  adId true string 广告ID
 associateId false string 广告关联内容ID
 adName true string 广告名称
 adCode true string 广告编码
 adImage true string 广告图片
 adDepict false string 广告内容
 adUrl false string 广告链接
 广告信息
 */

@property(nonatomic,copy)NSString *adId;
@property(nonatomic,copy)NSString *associateId;
@property(nonatomic,copy)NSString *adName;
@property(nonatomic,copy)NSString *adCode;
@property(nonatomic,copy)NSString *adImage;
@property(nonatomic,copy)NSString *adDepict;
@property(nonatomic,copy)NSString *adUrl;
@property(nonatomic,copy)NSString *video;
@end
