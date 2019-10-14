//
//  CCMyMessageViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/10/27.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCNoticModel.h"
#import "CCNoticDetailModel.h"
@interface CCMyMessageViewController : UIViewController
@property (nonatomic,strong)CCNoticModel *noticModel;
@property (nonatomic,strong)CCNoticDetailModel *noticDetailModel;
@end
