//
//  CCThreeImageTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/21.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCThreeImageTableViewCell.h"

@interface CCThreeImageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *centerImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end


@implementation CCThreeImageTableViewCell


- (void)awakeFromNib {
    [_titleLable setTextColor:[UIColor colorWithHexString:@"#3f3f3f"]];
    [_titleLable setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
    ;
    [_timeLable setTextColor:[UIColor colorWithHexString:@"#838383"]];
    [_timeLable setFont:[UIFont systemFontOfSize:12.0/360.0*ScreenWidth]];

}

+ (instancetype)setThreeImageCell{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
