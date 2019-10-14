//
//  CCOneImageTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/21.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCOneImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@interface CCOneImageTableViewCell ()
{
    UIImageView *_play;
}
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end



@implementation CCOneImageTableViewCell

-(void)setInforModel:(CCSecondThredModel *)inforModel{
    if (_inforModel!=inforModel) {
        _inforModel=inforModel;
        if ([_inforModel.video isEqualToString:@""]) {
            [_leftImage removeAllSubviews];
        }else {
            _play=[[UIImageView alloc]initWithFrame:CGRectMake(42.0/360.0*ScreenWidth, 22.0/667.0*ScreenHeight, 35.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
            _play.image=[UIImage imageNamed:@"banner_bofang"];
            [_leftImage addSubview:_play];
        }

        [self.leftImage sd_setImageWithURL:[NSURL URLWithString:_inforModel.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        self.titleLable.text=_inforModel.title;
        self.detailLable.text=_inforModel.descriptions;
        self.timeLable.text=_inforModel.createDateStr;

        
    }
}

- (void)awakeFromNib {
    [_titleLable setTextColor:[UIColor colorWithHexString:@"#3f3f3f"]];
    [_titleLable setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
    [_detailLable setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
    [_detailLable setTextColor:[UIColor colorWithHexString:@"#838383"]];
    [_timeLable setTextColor:[UIColor colorWithHexString:@"#838383"]];
    [_timeLable setFont:[UIFont systemFontOfSize:12.0/360.0*ScreenWidth]];
}

+ (instancetype)setOneImageCell{
     return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
