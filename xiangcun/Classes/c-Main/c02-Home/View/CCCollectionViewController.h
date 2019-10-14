//
//  CCCollectionViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/11/9.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSecondThredModel.h"
#import "CCSecListModel.h"
@interface CCCollectionViewController : UIViewController
@property (nonatomic,strong)CCSecondThredModel *secondmodel;
@property (nonatomic,strong)CCSecListModel *secListmodel;
@end
