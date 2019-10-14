//
//  CCHistorySearchCell.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/28.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSecondThredModel.h"
@interface CCHistorySearchCell : UITableViewCell
@property (nonatomic,strong)CCSecondThredModel *inforModel;
@property (nonatomic,strong)UIImageView *tourImage;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *timeLble;

@end
