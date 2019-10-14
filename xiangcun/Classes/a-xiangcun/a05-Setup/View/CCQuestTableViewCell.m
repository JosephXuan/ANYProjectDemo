//
//  CCQuestTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/18.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCQuestTableViewCell.h"

@implementation CCQuestTableViewCell{
    UILabel *_zhuce;
    
    UILabel *_detail;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setQuestionModel:_questionModel];
        _zhuce=[[UILabel alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth,10.0/667.0*ScreenHeight, 50.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
        
        [_zhuce setFont:[UIFont systemFontOfSize:15.0/360.0*ScreenWidth]];
        _zhuce.textColor=[UIColor blueColor];
        [self.contentView addSubview:_zhuce];
        
        _detail=[[UILabel alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth, 28.0/667.0*ScreenHeight, ScreenWidth-20.0/360.0*ScreenWidth, 50.0/667.0*ScreenHeight)];
        _detail.numberOfLines=0;
        //_detail.text=@"扫描二维码->免费下载“健康领航->打开客户端”";
        [_detail setFont:[UIFont systemFontOfSize:13.0/360.0*ScreenWidth]];
        _detail.textColor=[UIColor colorWithHexString:@"#838383"];
        [self.contentView addSubview:_detail];
        
    }
    return self;
}


-(void)setQuestionModel:(CCNoticDetailModel *)questionModel{
    if (_questionModel!=questionModel) {
        _questionModel=questionModel;
        
        
         _zhuce.text=_questionModel.title;
        
        _detail.text=_questionModel.content;
    }
}


- (void)awakeFromNib {
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
