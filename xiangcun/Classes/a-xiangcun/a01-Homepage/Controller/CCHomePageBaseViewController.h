//
//  CCHomePageBaseViewController.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLabelsTabbarItem.h"

@interface CCHomePageBaseViewController : UIViewController
@property (nonatomic,strong) CCLabelsTabbarItem *viewControllerItem;

@property (nonatomic, assign) BOOL gesturePrepared;
@property (nonatomic,strong) UIButton *btns;
@end
