//
//  CCExhibitionViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHomePageBaseViewController.h"
#import "CCNowExihibitionModel.h"
#import "CCWillExihibitionModel.h"
#import "CCHistoryExihibitionModel.h"
#import "CCSecListModel.h"
@interface CCExhibitionViewController : CCHomePageBaseViewController

@property (nonatomic,strong)CCWillExihibitionModel *willModel;
@property (nonatomic,strong)CCHistoryExihibitionModel *historyModel;
@property (nonatomic, assign)BOOL exihibition;
@property (nonatomic,strong)CCNowExihibitionModel *nowModel;
@property (nonatomic,strong)CCSecListModel *secListmodel;
@property (nonatomic,strong)UITableView *exihibitioning;
@property (nonatomic,strong)UITableView *histroyTableView;
@property (nonatomic,strong)UITableView *nowTableView;

@end