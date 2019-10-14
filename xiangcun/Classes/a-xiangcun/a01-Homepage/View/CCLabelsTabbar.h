//
//  CCLabelsTabbar.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/7.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LABELTABBAR_HEIGHT 41
@class CCLabelsTabbar,CCLabelsTabbarItem;


@protocol CCLabelsTabbarDelegate <NSObject>

@optional
- (void)labelsTabbar:(CCLabelsTabbar *)tabbar didSelectedItem:(CCLabelsTabbarItem *)item;

@end

@interface CCLabelsTabbar : UIView
@property (nonatomic,weak) id<CCLabelsTabbarDelegate> delegate;

@property (nonatomic,strong) NSArray *items;

@property (nonatomic, assign) NSInteger sliderIndex;
@end
