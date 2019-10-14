//
//  CCPlantTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/23.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCPlantTableViewCell.h"

@implementation CCPlantTableViewCell{
    
    UIButton *btn;
    UIView *_rightView;
    UILabel *_label;
    UIView *_line;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setClassModel:_classModel];
        self.contentView.backgroundColor=[UIColor clearColor];
        _label =[[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, 125.0/360.0*ScreenWidth, 42.0/667.0*ScreenHeight)];
        _label.userInteractionEnabled=YES;
        _label.textAlignment=NSTextAlignmentCenter;
        _label.textColor=[UIColor colorWithHexString:@"#838383"];
        _label.highlightedTextColor=[UIColor colorWithHexString:@"#1ab750"];
        [self.contentView addSubview:_label];
        
//        _line=[[UIView alloc]initWithFrame:CGRectMake(124, 0,1 , 42)];
//        _line.backgroundColor=[UIColor blackColor];
//        _line.alpha=0.2;
//        [self.contentView addSubview:_line];
        _rightView=[[UIView alloc]initWithFrame:CGRectMake(124.0/360.0*ScreenWidth, 0.0,1.0/360.0*ScreenWidth , 42.0/667.0*ScreenHeight)];
        _rightView.backgroundColor=[UIColor blackColor];
        _rightView.alpha=0.2;
        [self.contentView addSubview:_rightView];
        
        
        UILabel *bottomView=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 41.0/667.0*ScreenHeight,125.0/360.0*ScreenWidth , 1.0/667.0*ScreenHeight)];
        bottomView.backgroundColor=[UIColor grayColor];
        bottomView.alpha=0.2;
        [self.contentView addSubview:bottomView];
        
        UILabel *headView=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0,125.0/360.0*ScreenWidth , 1.0/667.0*ScreenHeight)];
        headView.backgroundColor=[UIColor grayColor];
        headView.alpha=0.2;
        [self.contentView addSubview:headView];
        
        
    }
    
    return self;
}

#pragma mark - 方法未实现
- (void)setClassModel:(CCClassroomModel *)classModel {
    
    if (_classModel!=classModel) {
        _classModel = classModel;
        
        _label.text=_classModel.name;
       // NSLog(@"_classModel.name%@",_classModel.name);
                }
        
  
}
- (void)awakeFromNib {
    [self setClassModel:_classModel];
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
   
    //_rightView.hidden=YES;
    
    
}

@end
