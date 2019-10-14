//
//  CCComendTableView.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/20.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCInformationModel.h"
#import "CCDetailModel.h"

@interface CCComendTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)CCInformationModel *inforModel;
@property (nonatomic,strong)CCDetailModel *detailModel;
@property (nonatomic,strong)UINavigationController *nav;
@end
