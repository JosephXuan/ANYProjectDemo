//
//  CCCommendCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/11.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCCommendCell.h"
#import "UIImageView+WebCache.h"

@interface CCCommendCell ()
@property (nonatomic,weak) UIImageView *coverImageView;
@property (nonatomic, weak) UILabel *mainTitle;
@property (nonatomic, weak) UILabel *subTitle;
@end

@implementation CCCommendCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        [self setInfomationModel:_infomationModel];
    }
    return self;
}
- (void)setUp {
    
    //--------今日资讯下方单元格属性－－－－－－－
    UIImageView *coverImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:coverImageView];
    [coverImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [coverImageView autoSetDimension:ALDimensionHeight toSize:100.0/667.0*ScreenHeight];
    coverImageView.layer.cornerRadius=10.0/360.0*ScreenWidth;
    coverImageView.layer.masksToBounds=YES;
    self.coverImageView = coverImageView;
    
    
    UILabel *mainTitle = [[UILabel alloc]init];//WithFrame:CGRectMake(5.0/360.0*ScreenWidth, 78.0/667.0*ScreenHeight, 150.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];;
    mainTitle.textColor = CCColorString(@"#222222");
    mainTitle.font = [UIFont systemFontOfSize:14.0/360.0*ScreenWidth];
    mainTitle.numberOfLines=2;
    //mainTitle.textAlignment=;
    [self.contentView addSubview:mainTitle];
    self.mainTitle = mainTitle;
    [self.mainTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:coverImageView];
    [self.mainTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:coverImageView withOffset:10];
    [self.mainTitle autoSetDimension:ALDimensionHeight toSize:40.0/667.0*ScreenHeight];
    [self.mainTitle autoSetDimension:ALDimensionWidth toSize:150.0/360.0*ScreenWidth];
   
    UILabel *subTitle = [[UILabel alloc]init];
    subTitle.textColor = CCColor(133, 133, 133);
    subTitle.font = [UIFont systemFontOfSize:12.0/360.0*ScreenWidth];
    subTitle.numberOfLines=0;
    [self.contentView addSubview:subTitle];
    self.subTitle = subTitle;
    [subTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:coverImageView];
    [subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:mainTitle withOffset:3];
    [subTitle autoSetDimension:ALDimensionHeight toSize:14.0/667.0*ScreenHeight];
    [self.subTitle autoSetDimension:ALDimensionWidth toSize:150.0/360.0*ScreenWidth];
    
}
- (void)awakeFromNib {
    [self setInfomationModel:_infomationModel];
}
- (void)setInfomationModel:(CCInformationModel *)infModel {
    
    if (_infomationModel!=infModel) {
        _infomationModel = infModel;
        [_coverImageView sd_setImageWithURL:[NSURL URLWithString:infModel.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        
        _mainTitle.text = infModel.title;
       _subTitle.text = infModel.descriptions;
        
        if ([_infomationModel.video isEqualToString:@""]) {
            [self.coverImageView removeAllSubviews];
        }else {
            [self.coverImageView removeAllSubviews];
            UIImageView *play=[[UIImageView alloc]initWithFrame:CGRectMake(63.0/360.0*ScreenWidth, 33.0/667.0*ScreenHeight, 30.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
            play.image=[UIImage imageNamed:@"banner_bofang"];
            [self.coverImageView addSubview:play];
        }
        
    }
}

@end
