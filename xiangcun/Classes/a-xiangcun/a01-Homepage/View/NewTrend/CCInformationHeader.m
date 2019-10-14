//
//  CCInformationHeader.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/8.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCInformationHeader.h"


@interface CCInformationHeader ()


@end

@implementation CCInformationHeader
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    UIImageView *inforImage = [[UIImageView alloc]init];
    [self addSubview:inforImage];
    self.inforImage = inforImage;
    [inforImage autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:5];
    [inforImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:7];
    [inforImage autoSetDimensionsToSize:CGSizeMake(20, 20)];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:17.0/360.0*ScreenWidth];
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:inforImage withOffset:5];
    [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:7];
    
    UIImageView *arrowImage = [[UIImageView alloc]init];
    [self addSubview:arrowImage];
    self.arrowImage = arrowImage;
    [arrowImage autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:0];
    [arrowImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:10];
    [arrowImage autoSetDimensionsToSize:CGSizeMake(15, 15)];
    
    UILabel *subTitle = [[UILabel alloc]init];
    subTitle.textColor = CCColor(31, 182, 10);
    subTitle.font = [UIFont systemFontOfSize:14.0/360.0*ScreenWidth];
    [self addSubview:subTitle];
    self.subTitle = subTitle;
    [subTitle autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:arrowImage withOffset:-4];
    [subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:9];

    

}
@end
