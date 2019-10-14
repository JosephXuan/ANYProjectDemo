//
//  CCMineTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/12.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCMineTableViewCell.h"

@interface CCMineTableViewCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *icon;

@end


@implementation CCMineTableViewCell

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
    
    UIImageView *icon = [[UIImageView alloc]init];
    [contenview addSubview:icon];
    self.icon = icon;
    [icon autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:contenview withOffset:20];
    [icon autoAlignAxis:ALAxisHorizontal toSameAxisOfView:contenview];
    [icon autoSetDimensionsToSize:CGSizeMake(21.0/360.0*ScreenWidth, 21.0/667.0*ScreenHeight)];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [contenview addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
    self.titleLabel = titleLabel;
    [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:icon withOffset:20];
    [titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:contenview];
    
    UIImageView *arrowImage = [[UIImageView alloc]init];
    [contenview addSubview:arrowImage];
    arrowImage.image = [UIImage imageNamed:@"arrow"];
    [arrowImage autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:contenview withOffset:-20];
    
    [arrowImage autoAlignAxis:ALAxisHorizontal toSameAxisOfView:contenview];
    [arrowImage autoSetDimensionsToSize:CGSizeMake(16.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight)];

}
- (void)setModel:(CCMineModel *)model {
    _model = model;
    self.icon.image = [UIImage imageNamed:model.imageString];
    self.titleLabel.text = model.titleString;

}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
