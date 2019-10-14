//
//  CCSetUpCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/9.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCSetUpCell.h"


@interface CCSetUpCell ()
@property (nonatomic, weak) UILabel *titleLabel;

@end


@implementation CCSetUpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)setUp {
    UIView *contenview = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 55.0/667.0*ScreenHeight)];
    contenview.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = CCColorString(@"#f4f4f4");
    [self.contentView addSubview:contenview];
    
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [contenview addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    self.titleLabel = titleLabel;
    [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:contenview withOffset:20];
    [titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:contenview];
    
    UIImageView *arrowImage = [[UIImageView alloc]init];
    [contenview addSubview:arrowImage];
    arrowImage.image = [UIImage imageNamed:@"arrow"];
    [arrowImage autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:contenview withOffset:-20];

    [arrowImage autoAlignAxis:ALAxisHorizontal toSameAxisOfView:contenview];
    [arrowImage autoSetDimensionsToSize:CGSizeMake(16.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight)];
    


}
- (void)setModel:(CCSetUpModel *)model {
    _model = model;
    self.titleLabel.text = model.titleString;
    
}
@end
