//
//  CCSecondNewThredTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/27.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCSecondNewThredTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CCSecondNewThredTableViewCell ()
{
    UIImageView *_leftImage;
    UILabel *_titleLable;
    UILabel *_detailLable;
    UILabel *_timeLable;
    UIImageView *_play;
}

@end



@implementation CCSecondNewThredTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setModel:_model];
        _leftImage=[[UIImageView alloc]initWithFrame:CGRectMake(6.0/360.0*ScreenWidth, 5.0, 120.0/360.0*ScreenWidth, 100.0/667.0*ScreenHeight-20.0/667.0*ScreenHeight)];
        _leftImage.layer.cornerRadius=10.0/360.0*ScreenWidth;
        _leftImage.layer.masksToBounds=YES;
        //_leftImage.image=[UIImage imageNamed:@"53"];
        [self.contentView addSubview:_leftImage];
        
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(135.0/360.0*ScreenWidth, 11.0/667.0*ScreenHeight, ScreenWidth-(160.0/360.0*ScreenWidth), 40.0/667.0*ScreenHeight)];
       // _titleLable.text=@"促进农业创新和可持续发展";
        _titleLable.numberOfLines=0;
        _titleLable.textColor=[UIColor colorWithHexString:@"#3f3f3f"];
        [_titleLable setFont:[UIFont systemFontOfSize:16.0/360.0*ScreenWidth]];
        [self.contentView addSubview:_titleLable];
        
        _detailLable=[[UILabel alloc]initWithFrame:CGRectMake(135.0/360.0*ScreenWidth, 58.0/667.0*ScreenHeight, ScreenWidth-(130.0/360.0*ScreenWidth), 10.0/667.0*ScreenHeight)];
                _detailLable.textColor=[UIColor colorWithHexString:@"838383"];
        [_detailLable setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
        [self.contentView addSubview:_detailLable];
        
        
        _timeLable=[[UILabel alloc]initWithFrame:CGRectMake(135.0/360.0*ScreenWidth, 77.0/667.0*ScreenHeight, 180.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight)];
        _timeLable.text=@"2016.06.05";
     _timeLable.textColor=[UIColor colorWithHexString:@"b3b3b3"];
        [_timeLable setFont:[UIFont systemFontOfSize:12.0/360.0*ScreenWidth]];
        [self.contentView addSubview:_timeLable];
        
        
        
        
  }
    return self;
}

- (void)awakeFromNib {
    [self setModel:_model];
}
-(void)setModel:(CCSecondThredModel *)model{
    if (_model!=model) {
        _model=model;
        if ([_model.video isEqualToString:@""]) {
            [_leftImage removeAllSubviews];
        }else {
            [_leftImage removeAllSubviews];
            _play=[[UIImageView alloc]initWithFrame:CGRectMake(45.0/360.0*ScreenWidth, 25.0/667.0*ScreenHeight, 40.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight)];
            _play.image=[UIImage imageNamed:@"banner_bofang"];
            [_leftImage addSubview:_play];
        }
        
        [_leftImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        _titleLable.text=model.title;
        _detailLable.text=model.descriptions;
        _timeLable.text=_model.createDateStr;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
