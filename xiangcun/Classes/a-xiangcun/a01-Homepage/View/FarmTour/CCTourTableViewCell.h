//
//  CCTourTableViewCell.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/19.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSecondThredModel.h"
@interface CCTourTableViewCell : UITableViewCell

@property (nonatomic,strong)CCSecondThredModel *inforModel;
+ (instancetype)nanjingTourCell;

@end
