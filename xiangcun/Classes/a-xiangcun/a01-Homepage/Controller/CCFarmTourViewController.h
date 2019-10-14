//
//  CCFarmTourViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHomePageBaseViewController.h"
#import "CCSecondThredModel.h"

#import "CCFarmTourModel.h"
#import "CCClassroomModel.h"
#import "CCAdDetailModel.h"
@interface CCFarmTourViewController : CCHomePageBaseViewController
@property (nonatomic,strong)CCFarmTourModel *farmTourModel;
@property (nonatomic,strong)CCClassroomModel *areaModeld;
@property (nonatomic,strong)CCAdDetailModel *adDetailModel;
@property (nonatomic,strong)CCSecondThredModel *listModel;
@property (nonatomic, assign)BOOL miroFilm;
@end
