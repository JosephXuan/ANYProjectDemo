//
//  CCClassroomItemCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/12.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCClassroomItemCell.h"

@interface CCClassroomItemCell ()
@property (nonatomic, weak) UIImageView *itemImage;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation CCClassroomItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    UIImageView *itemImage = [[UIImageView alloc]init];
    [self.contentView addSubview:itemImage];
    [itemImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentView];
    [itemImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
    [itemImage autoSetDimensionsToSize:CGSizeMake(40.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight)];
    self.itemImage = itemImage;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:12.0/360.0*ScreenWidth];
    [self.contentView addSubview:titleLabel];
    [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:itemImage withOffset:5.0/360.0*ScreenWidth];
    [titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:itemImage];
    self.titleLabel = titleLabel;
}
- (void)setModel:(CCClassroomItemModel *)model {
    _model = model;
    self.itemImage.image = [UIImage imageNamed:model.itemImage];
    self.titleLabel.text = model.titleString;
}

@end
