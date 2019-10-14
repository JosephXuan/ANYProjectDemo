//
//  CCOneImageTableViewCell.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/21.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSecondThredModel.h"
@interface CCOneImageTableViewCell : UITableViewCell

@property (nonatomic,strong)CCSecondThredModel *inforModel;

+ (instancetype)setOneImageCell;
@end
