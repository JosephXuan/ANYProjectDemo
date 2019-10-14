//
//  CCGrayTableViewCell.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/19.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPriceModel.h"
@interface CCGrayTableViewCell : UITableViewCell


@property (nonatomic,strong)CCPriceModel *priceModel;
+ (instancetype)grayCell;

@end
