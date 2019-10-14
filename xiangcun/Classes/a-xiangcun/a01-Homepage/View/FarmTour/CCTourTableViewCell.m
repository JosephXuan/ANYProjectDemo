//
//  CCTourTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/19.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCTourTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@interface CCTourTableViewCell ()
{
    UIImageView *_bgImageView;
    UIImageView *_play;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *zanImage;
@property (weak, nonatomic) IBOutlet UILabel *zanLable;


@end


@implementation CCTourTableViewCell
-(void)setInforModel:(CCSecondThredModel *)inforModel{
    if (_inforModel!=inforModel) {
        _inforModel=inforModel;
        if ([_inforModel.video isEqualToString:@""]) {
            [_bgImage removeAllSubviews];
        }else {
            _play=[[UIImageView alloc]initWithFrame:CGRectMake(161.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight, 35.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
            _play.image=[UIImage imageNamed:@"banner_bofang"];
            [_bgImage addSubview:_play];
        }
        
        [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_inforModel.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        self.titleLable.text=[NSString stringWithFormat:@"   %@",_inforModel.title];
       
        
        
    }
}

- (void)awakeFromNib {
    [self setInforModel:_inforModel];
    [_titleLable setTextColor:[UIColor whiteColor]];
    [_titleLable setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
    
    _titleLable.textAlignment=NSTextAlignmentLeft;
    _titleLable.backgroundColor=[UIColor colorWithHexString:@"#000000" alpha:0.6];
   // _titleLable.layer.borderWidth=1.0/360.0*ScreenWidth;
    _titleLable.layer.cornerRadius=10.0/360.0*ScreenWidth;
    _titleLable.layer.masksToBounds=YES;
    _zanImage.image=nil;
    _zanLable.text=nil;

}


+ (instancetype)nanjingTourCell{
   
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
