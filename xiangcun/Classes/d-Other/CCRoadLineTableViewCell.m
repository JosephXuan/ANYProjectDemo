//
//  CCRoadLineTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/11/14.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCRoadLineTableViewCell.h"

@implementation CCRoadLineTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0.0/667.0*ScreenHeight, self.contentView.size.width-77.0/360.0*ScreenWidth, self.contentView.size.height)];
        _title.numberOfLines=0;
        _title.font=[UIFont systemFontOfSize:15.0/360.0*ScreenWidth];
        _title.textColor=[UIColor colorWithHexString:@"#3f3f3f"];
        [self.contentView addSubview:_title];
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
