//
//  CCHistorySearchCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/28.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHistorySearchCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@interface CCHistorySearchCell (){
    
    UIImageView *_play;
    
    
}
@end



@implementation CCHistorySearchCell



-(void)setInforModel:(CCSecondThredModel *)inforModel{
    if (_inforModel!=inforModel) {
        _inforModel=inforModel;
        
        [self.tourImage sd_setImageWithURL:[NSURL URLWithString:_inforModel.image] placeholderImage:[UIImage imageNamed:@"zanwutupian2"]];
        self.titleLable.text=_inforModel.title;
        //self.detailLable.text=_inforModel.descriptions;
        self.timeLble.text=_inforModel.descriptions;
        
        
    }
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
        //self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}
-(void)setUp{
    _tourImage=[[UIImageView alloc]initWithFrame:CGRectMake(6.0/360.0*ScreenWidth, 10.0/667.0*ScreenHeight, 120.0/360.0*ScreenWidth, 80.0/667.0*ScreenHeight)];
    _tourImage.layer.cornerRadius=10.0/360.0*ScreenWidth;
    _tourImage.layer.masksToBounds=YES;
    [self.contentView addSubview:_tourImage];
    
    _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(130.0/360.0*ScreenWidth, 11.0/667.0*ScreenHeight, 200.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight)];
    _titleLable.numberOfLines=0;
    [_titleLable setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
    [_titleLable setTextColor:[UIColor colorWithHexString:@"#3f3f3f"]];
    [self.contentView addSubview:_titleLable];
     
    _timeLble=[[UILabel alloc]initWithFrame:CGRectMake(130.0/360.0*ScreenWidth, 45.0/667.0*ScreenHeight, 200.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];
    _timeLble.numberOfLines=0;
    [_timeLble setFont:[UIFont systemFontOfSize:14.0/360.0*ScreenWidth]];
    [_timeLble setTextColor:[UIColor colorWithHexString:@"#838383"]];
    [self.contentView addSubview:_timeLble];
    
    
    
    
}

//-(void)setTitleName:(NSString *)titleName{
//    
//    _titleLable.text=titleName;
//    
//    
//}
//
//-(void)setTimeName:(NSString *)timeName{
//    
//    _timeLble.text=timeName;
//    
//    
//}
//-(void)setImageName:(NSString *)imageName{
//    
//    _tourImage.image=[UIImage imageNamed:imageName];
//    
//    
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
