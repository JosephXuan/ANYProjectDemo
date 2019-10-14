//
//  CCPlantMoreViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/10/13.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CCSecondThredModel.h"
#import "CCSecListModel.h"

@interface CCPlantMoreViewController : UIViewController
@property (nonatomic, assign)BOOL miroFilm;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *ids;
@property (nonatomic,strong)CCSecondThredModel *secondmodel;
@property (nonatomic,strong)CCSecListModel *secListmodel;
@end
