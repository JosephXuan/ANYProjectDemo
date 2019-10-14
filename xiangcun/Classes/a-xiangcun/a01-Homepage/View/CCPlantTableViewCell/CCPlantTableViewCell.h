//
//  CCPlantTableViewCell.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/23.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCClassroomItemModel.h"
#import "CCClassroomModel.h"
@interface CCPlantTableViewCell : UITableViewCell

@property(nonatomic,copy)CCClassroomItemModel *model;
@property(nonatomic,strong)CCClassroomModel *classModel;

@end
