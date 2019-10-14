//
//  CCMicroFilmViewController.h
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
@interface CCMicroFilmViewController : CCHomePageBaseViewController
@property (nonatomic,strong)CCInformationModel *inforModel;
@property (nonatomic,strong) CCAdddModel *microModel;
@property (nonatomic,strong)CCAdDetailModel *adDetailModel;
@property (nonatomic, assign)BOOL miroFilm;
@property (nonatomic,strong)CCDetailModel *detailModel;
@property (nonatomic,strong)UICollectionView *informationList;
@end
