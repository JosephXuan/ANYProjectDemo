//
//  CCNewTrendViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCHomePageBaseViewController.h"
#import "CCAdddModel.h"
#import "CCInformationModel.h"
#import "CCNoticModel.h"
#import "CCDetailModel.h"
#import "CCAdDetailModel.h"
#import "CCNoticDetailModel.h"
@interface CCNewTrendViewController : CCHomePageBaseViewController
@property (nonatomic,strong)CCAdddModel *model;
@property (nonatomic,strong)CCInformationModel *inforModel;
@property (nonatomic,strong)CCNoticModel *noticModel;
@property (nonatomic,strong)CCDetailModel *detailModel;
@property (nonatomic,strong)CCAdDetailModel *adDetailModel;
@property (nonatomic,strong)CCNoticDetailModel *noticDetailModel;
@property (nonatomic, assign)BOOL miroFilm;
@end
