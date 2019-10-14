//
//  CCLabelsTabbarCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/7.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCLabelsTabbarCell.h"
#import "CCLabelsTabbarItem.h"
#import <UIView+AutoLayout.h>

@interface CCLabelsTabbarCell ()
@property (nonatomic,weak) UIButton *titleButton;

@end


@implementation CCLabelsTabbarCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] )
    {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.userInteractionEnabled = NO;
    [self.contentView addSubview:titleButton];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    [titleButton autoCenterInSuperview];
    self.titleButton = titleButton;
    [titleButton setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [titleButton setTitleColor:AppMainColor forState:UIControlStateSelected];
}

- (void)setItem:(CCLabelsTabbarItem *)item
{
    _item = item;
    self.titleButton.selected = item.selected;
    [self.titleButton setTitle:item.title forState:UIControlStateSelected];

    [self.titleButton setTitle:item.title forState:UIControlStateNormal];
 }

@end
