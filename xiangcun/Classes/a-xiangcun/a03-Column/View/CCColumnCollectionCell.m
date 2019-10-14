//
//  CCColumnCollectionCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/9.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCColumnCollectionCell.h"


@interface CCColumnCollectionCell ()
@property (nonatomic, strong) UIImageView *columnImage;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CCColumnCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)setUp {
    UIImageView *columnImage = [[UIImageView alloc]init];
    [self.contentView addSubview:columnImage];
    
    self.columnImage = columnImage;
    [columnImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
    [columnImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentView];
    [columnImage autoSetDimensionsToSize:CGSizeMake(60, 60)];

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    [self.contentView addSubview:titleLabel];
    titleLabel.textColor=[UIColor colorWithHexString:@"#676767"];
    self.titleLabel = titleLabel;
    [titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentView];
    [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:columnImage withOffset:12];
    
}
- (void)setColumnModel:(CCColumnModel *)columnModel {
    _columnModel = columnModel;
    self.columnImage.image = [UIImage imageNamed:columnModel.imageName];
    self.titleLabel.text = columnModel.titleString;
    
}
@end
