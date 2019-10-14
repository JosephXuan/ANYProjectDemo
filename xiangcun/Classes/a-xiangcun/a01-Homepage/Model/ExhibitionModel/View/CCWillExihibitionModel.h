//
//  CCWillExihibitionModel.h
//  xiangcun
//
//  Created by 李孝帅 on 16/10/10.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  article true array[object]
 id true string ID
 title false string 标题
 image true string 图片地址
 description true string 简介
 */
@interface CCWillExihibitionModel : NSObject
@property (nonatomic,copy)NSString *ids;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *descriptions;
@property (nonatomic,copy)NSString *video;
@property (nonatomic,copy)NSString *createDateStr;
@end
