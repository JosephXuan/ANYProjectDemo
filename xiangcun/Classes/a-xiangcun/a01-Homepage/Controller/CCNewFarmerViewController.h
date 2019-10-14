//
//  CCNewFarmerViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHomePageBaseViewController.h"

#import "CCAdddModel.h"
#import "CCAdDetailModel.h"
#import "CCSecondThredModel.h"
#import "CCSecListModel.h"
@interface CCNewFarmerViewController : CCHomePageBaseViewController

@property (nonatomic,strong) CCAdddModel *newsFarmModel;
@property (nonatomic,strong)CCAdDetailModel *adDetailModel;
@property (nonatomic,strong)CCSecondThredModel *inforModel;
@property (nonatomic,strong)CCSecListModel *model;
@property (nonatomic, strong) UITableView *rich;
@property (nonatomic, assign)BOOL miroFilm;
@end
