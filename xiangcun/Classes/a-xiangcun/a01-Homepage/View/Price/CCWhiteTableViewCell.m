//
//  CCWhiteTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/19.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCWhiteTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@interface CCWhiteTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *souceLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *biggestPlable;
@property (weak, nonatomic) IBOutlet UILabel *lowestLable;
@property (weak, nonatomic) IBOutlet UILabel *wholasleLable;

@end




@implementation CCWhiteTableViewCell

-(void)setPriceModel:(CCPriceModel *)priceModel{
    if (_priceModel!=priceModel) {
        _priceModel=priceModel;
        self.nameLable.text=_priceModel.productName;
        self.souceLable.text=_priceModel.productSource;
        NSString*str=[_priceModel.createDateStr substringWithRange:NSMakeRange(5, 5)];
        self.timeLable.text=str;
        self.biggestPlable.text=_priceModel.highestPrice;
        self.lowestLable.text=_priceModel.minimumPrice;
        self.wholasleLable.text=_priceModel.tradePrice;
        
    }
}



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"CCWhiteTableViewCell" owner:nil options:nil].firstObject;
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
    
}

+ (instancetype)whiteCell{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
