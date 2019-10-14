//
//  CCClassCollectionViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/11.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCClassCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CCClassCollectionViewCell ()
@property (nonatomic,weak) UIImageView *coverImageView;
@property (nonatomic, weak) UILabel *mainTitle;

@end

@implementation CCClassCollectionViewCell


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
    [coverImageView autoSetDimension:ALDimensionHeight toSize:70.0/667.0*ScreenHeight];
    coverImageView.layer.cornerRadius=10.0/360.0*ScreenWidth;
    coverImageView.layer.masksToBounds=YES;
    //coverImageView.image=[UIImage imageNamed:@"54"];
    self.coverImageView = coverImageView;
    
    
    UILabel *mainTitle = [[UILabel alloc]init];
    mainTitle.textColor = CCColorString(@"#222222");
    mainTitle.font = [UIFont systemFontOfSize:14.0/360.0*ScreenWidth];
    mainTitle.numberOfLines=2;
    //mainTitle.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:mainTitle];
   // mainTitle.text=@"中州";
    self.mainTitle = mainTitle;
    [self.mainTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:coverImageView];
    [self.mainTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:coverImageView withOffset:15];
    [self.mainTitle autoSetDimension:ALDimensionHeight toSize:20.0/667.0*ScreenHeight];
    [self.mainTitle autoSetDimension:ALDimensionWidth toSize:110.0/360.0*ScreenWidth];
    
    
    
}
- (void)awakeFromNib {
    [self setInfomationModel:_infomationModel];
}
- (void)setInfomationModel:(CCInformationModel *)infModel {
    
    if (_infomationModel!=infModel) {
        _infomationModel = infModel;
        [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_infomationModel.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        
        _mainTitle.text = _infomationModel.title;
        
        
        if ([_infomationModel.video isEqualToString:@""]) {
            [self.coverImageView removeAllSubviews];
        }else {
            [self.coverImageView removeAllSubviews];
            UIImageView *play=[[UIImageView alloc]initWithFrame:CGRectMake(38.0/360.0*ScreenWidth, 28.0/667.0*ScreenHeight, 30.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight)];
            play.image=[UIImage imageNamed:@"banner_bofang"];
            [self.coverImageView addSubview:play];
        }
        
    }
}



@end
