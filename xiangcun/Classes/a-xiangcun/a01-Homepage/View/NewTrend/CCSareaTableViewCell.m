//
//  CCSareaTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/13.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCSareaTableViewCell.h"

@interface CCSareaTableViewCell ()
@property (nonatomic, weak) UILabel *mainTitle;

@end

@implementation CCSareaTableViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        [self setAreaModel:_areaModel];
    }
    return self;
}
- (void)setUp {
 
    UILabel *mainTitle = [[UILabel alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, 0.0/667.0*ScreenHeight, 150.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];;
    mainTitle.textColor = CCColorString(@"#222222");
    mainTitle.font = [UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    [self.contentView addSubview:mainTitle];
    self.mainTitle = mainTitle;
    
    
    
}
- (void)awakeFromNib {
    [self setAreaModel:_areaModel];
}
- (void)setAreaModel:(CCClassroomModel *)areaModel{
    
    if (_areaModel!=areaModel) {
        _areaModel = areaModel;
                _mainTitle.text = areaModel.name;
        
        
    }
}

@end
