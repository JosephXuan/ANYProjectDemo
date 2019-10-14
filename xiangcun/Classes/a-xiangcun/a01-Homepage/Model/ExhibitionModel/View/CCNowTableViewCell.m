//
//  CCNowTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/26.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCNowTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface CCNowTableViewCell ()
{
    UIImageView *_leftImage;
    UILabel *_titleLable;
    UILabel *_detailLable;
    UIImageView *_play;
}

@end

@implementation CCNowTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftImage =[[UIImageView alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, 11.0/667.0*ScreenHeight, 80.0/360.0*ScreenWidth, 70.0/667.0*ScreenHeight)];
        //_leftImage.image=[UIImage imageNamed:@"52"];
        _leftImage.layer.cornerRadius=10.0/360.0*ScreenWidth;
        _leftImage.layer.masksToBounds=YES;
        [self.contentView addSubview:_leftImage];
        
        
        UILabel *lable=[[UILabel alloc]init];
        lable.text=@"[详情]";
        lable.textColor=[UIColor colorWithHexString:@"#1ab750"];
        
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(100.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight, 151.0/360.0*ScreenWidth, 12.0/667.0*ScreenHeight)];
        //_titleLable.text=@"2016年1月22日-1月24日";
        [_titleLable setFont:[UIFont systemFontOfSize:12.0/360.0*ScreenWidth]];
        _titleLable.textColor=[UIColor colorWithHexString:@"#3f3f3f"];
        [self.contentView addSubview:_titleLable];
        
        _detailLable=[[UILabel alloc]initWithFrame:CGRectMake(100.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight, 151.0/360.0*ScreenWidth, 60.0/667.0*ScreenHeight)];
        
        //_detailLable.text=[NSString stringWithFormat:@"首届江苏名茶展销暨休闲观光农业博览会%@",lable.text];
        [_detailLable setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
        _detailLable.textColor=[UIColor colorWithHexString:@"#3f3f3f"];
        _detailLable.numberOfLines = 0;
        [self.contentView addSubview:_detailLable];
        
        
        
    }
    return self;
    
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(CCWillExihibitionModel *)model{
    if (_model!=model) {
        _model=model;
        if ([_model.video isEqualToString:@""]) {
            [_leftImage removeAllSubviews];
        }else {
            _play=[[UIImageView alloc]initWithFrame:CGRectMake(45.0/360.0*ScreenWidth, 25.0/667.0*ScreenHeight, 35.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
            _play.image=[UIImage imageNamed:@"banner_bofang"];
            [_leftImage addSubview:_play];
        }
        
        [_leftImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        _titleLable.text=model.createDateStr;
        _detailLable.text=model.descriptions;
       
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
