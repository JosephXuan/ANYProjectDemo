//
//  CCGrayTableViewCell.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/19.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCGrayTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@interface CCGrayTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *souceLble;
@property (weak, nonatomic) IBOutlet UILabel *timeLble;
@property (weak, nonatomic) IBOutlet UILabel *biggestPlable;
@property (weak, nonatomic) IBOutlet UILabel *lowestPlable;
@property (weak, nonatomic) IBOutlet UILabel *wholesaleLble;//批发



@end


@implementation CCGrayTableViewCell

-(void)setPriceModel:(CCPriceModel *)priceModel{
    if (_priceModel!=priceModel) {
        _priceModel=priceModel;
        self.nameLable.text=_priceModel.productName;
        self.souceLble.text=_priceModel.productSource;
        
        NSString*str=[_priceModel.createDateStr substringWithRange:NSMakeRange(5, 5)];
        self.timeLble.text=str;
        self.biggestPlable.text=_priceModel.highestPrice;
        self.lowestPlable.text=_priceModel.minimumPrice;
        self.wholesaleLble.text=_priceModel.tradePrice;
        
    }
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CCGrayTableViewCell" owner:nil options:nil].firstObject;
      
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
    
}

+ (instancetype)grayCell{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
