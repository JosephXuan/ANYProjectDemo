//
//  CCMyMessageTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/27.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCMyMessageTableViewCell.h"

@interface CCMyMessageTableViewCell ()
{
   
    UILabel *_titleLable;
    
    UILabel *_timeLable;
    
}

@end

@implementation CCMyMessageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setModel:_model];
        
        
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 5.0/667.0*ScreenHeight, ScreenWidth-(20.0/360.0*ScreenWidth), 40.0/667.0*ScreenHeight)];
        // _titleLable.text=@"促进农业创新和可持续发展";
        _titleLable.numberOfLines=0;
        _titleLable.textColor=[UIColor colorWithHexString:@"#3f3f3f"];
        [_titleLable setFont:[UIFont systemFontOfSize:16.0/360.0*ScreenWidth]];
        [self.contentView addSubview:_titleLable];
        
        
        
        _timeLable=[[UILabel alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight, 180.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight)];
        //_timeLable.text=@"2016.06.05";
        _timeLable.textColor=[UIColor colorWithHexString:@"b3b3b3"];
        [_timeLable setFont:[UIFont systemFontOfSize:12.0/360.0*ScreenWidth]];
        [self.contentView addSubview:_timeLable];
        
        
        
        
    }
    return self;
}

-(void)setModel:(CCNoticModel *)model{
    if (_model!=model) {
        _model=model;
        
        _titleLable.text=model.title;
       
        _timeLable.text=_model.createDateStr;
    }
    
}

- (void)awakeFromNib {
    [self setModel:_model];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
