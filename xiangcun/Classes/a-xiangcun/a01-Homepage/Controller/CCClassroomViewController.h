//
//  CCClassroomViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHomePageBaseViewController.h"
#import "CCAdddModel.h"
#import "CCAdDetailModel.h"
#import "CCInformationModel.h"
#import "CCDetailModel.h"
#import "CCClassroomModel.h"
@interface CCClassroomViewController : CCHomePageBaseViewController
@property (nonatomic, assign)BOOL miroFilm;
@property (nonatomic,strong)CCAdddModel *clssModel;
@property (nonatomic,strong)CCAdDetailModel *adDetailModel;
@property (nonatomic,strong)CCInformationModel *inforModel;
@property (nonatomic,strong)CCDetailModel *detailModel;
@property (nonatomic,strong)CCClassroomModel *fenleiModel;
@end
