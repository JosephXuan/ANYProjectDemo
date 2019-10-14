//
//  CommentStarView.m
//  zuileme
//
//  Created by jiuyi on 16/9/14.
//  Copyright © 2016年 Hefei JiuYi Network Technology Co.,Ltd. All rights reserved.
//

// 星星的宽
#define kWidth 15
// 星星的高
#define kHeight 15
// 两颗星星之间的间距
#define kMargin 5
// 星星的个数
#define kCount 5

#import "CommentStarView.h"

@interface CommentStarView ()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, assign) BOOL once;

@end

@implementation CommentStarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    
    self.bottomView = [[UIView alloc]init];
    [self addSubview:self.bottomView];
    
    self.topView = [[UIView alloc]init];
    self.topView.clipsToBounds = YES;
    [self addSubview:self.topView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_once) {
        _once = YES;
        
        self.bottomView.frame = self.bounds;
        self.topView.frame = self.bounds;
        
        for (int i = 0; i < kCount; i ++) {
            
            UIImageView *bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth+kMargin)*i, 0, kWidth, kHeight)];
            bottomImageView.image = [UIImage imageNamed:@"njy_star_gray"];
            UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth+kMargin)*i, 0, kWidth, kHeight)];
            topImageView.image = [UIImage imageNamed:@"njy_star_red"];
            [self.bottomView addSubview:bottomImageView];
            [self.topView addSubview:topImageView];
        }
       // self.topView.width = 0;
        CGFloat width = self.width / kCount;
        NSInteger index = self.starCount;
        self.topView.width = width * index;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    [self setStarWithTouch:touch];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    [self setStarWithTouch:touch];
}

- (void)setStarWithTouch:(UITouch *)touch {
    
    CGPoint point = [touch locationInView:self];
    CGFloat width = self.width / kCount;
    NSInteger index = point.x / width + 1;
    self.topView.width = width * index;
    self.starCount = index;
}

- (void)setStarCount:(NSInteger)starCount {
    _starCount=starCount;
    
}

@end
