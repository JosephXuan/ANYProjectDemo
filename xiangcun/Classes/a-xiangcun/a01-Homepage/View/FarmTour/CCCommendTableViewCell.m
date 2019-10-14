//
//  CCCommendTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/19.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCCommendTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "CommentStarView.h"
@interface CCCommendTableViewCell (){
    
    UIImageView *_bgImageView;
    UIImageView *_play;
    CommentStarView *_star;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;

@end


@implementation CCCommendTableViewCell



-(void)setInforModel:(CCSecondThredModel *)inforModel{
    if (_inforModel!=inforModel) {
        _inforModel=inforModel;
        if ([_inforModel.video isEqualToString:@""]) {
            [_bgImage removeAllSubviews];
        }else {
            _play=[[UIImageView alloc]initWithFrame:CGRectMake(65.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight, 35.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
            _play.image=[UIImage imageNamed:@"banner_bofang"];
            [_bgImage addSubview:_play];
        }
        
        [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_inforModel.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        self.titleLable.text=_inforModel.title;
        self.detailLable.text=_inforModel.descriptions;
        _star.starCount=_inforModel.recomLevel.integerValue;
//NSLog(@"红色星星个数 ==%ld",_star.starCount);
    }
}



+ (instancetype)commendCell{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    [self setInforModel:_inforModel];
    
    [self setInforModel:_inforModel];
    [_titleLable setTextColor:[UIColor blackColor]];
    [_titleLable setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
    
    [_detailLable setTextColor:[UIColor grayColor]];
    [_detailLable setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
    _detailLable.numberOfLines=0;
    
    _star=[[CommentStarView alloc]initWithFrame:CGRectMake(175.0/360.0*ScreenWidth, 37.0/667.0*ScreenHeight, 95.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    _star.userInteractionEnabled=NO;
    [self.contentView addSubview:_star];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
