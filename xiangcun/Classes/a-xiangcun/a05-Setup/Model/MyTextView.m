//
//  MyTextView.m
//  MJLife
//
//  Created by Joseph_Xuan on 16/6/23.
//  Copyright © 2016年 Joseph_Xuan. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self) {
        
        self.backgroundColor= [UIColor clearColor];
        
        //
        // _detailTextView.backgroundColor =kColorWithRGB(100, 100, 100);
        self.backgroundColor=[UIColor clearColor];
        self.layer.cornerRadius =10.0f;
        self.layer.masksToBounds =YES;

        
        UILabel *placeholderLabel = [[UILabel alloc]init];//添加一个占位label
        
        placeholderLabel.backgroundColor= [UIColor clearColor];
        
        placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
        
        [self addSubview:placeholderLabel];
        
        self.placeholderLabel= placeholderLabel; //赋值保存
        
        self.myPlaceholderColor= [UIColor lightGrayColor]; //设置占位文字默认颜色
        
        self.font= [UIFont systemFontOfSize:15.0/360.0*ScreenWidth]; //设置默认的字体
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
        
    }
    
    return self;
    
}
//这个 hasText  是一个 系统的 BOOL  属性，如果 UITextView 输入了文字  hasText 就是 YES，反之就为 NO。
- (void)textDidChange
{
    
    self.placeholderLabel.hidden = self.hasText;
    
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
//    //设置UILabel 的 y值
//    self.placeholderLabel.y=8;
//    //设置 UILabel 的 x 值
//    self.placeholderLabel.x=5;
//    //设置 UILabel 的 x
//    self.placeholderLabel.width=self.width-self.placeholderLabel.x*2.0;
    
    //根据文字计算高度
    
    CGSize maxSize =CGSizeMake(self.placeholderLabel.frame.size.width,MAXFLOAT);
    
    CGRect heightRect= [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.f]} context:nil];
    
    self.placeholderLabel.frame =CGRectMake(5.0/360.0*ScreenWidth, 8.0/667.0*ScreenHeight, self.frame.size.width-10*2, ceilf(heightRect.size.height));
    
}
- (void)setMyPlaceholder:(NSString*)myPlaceholder{
    
    _myPlaceholder= [myPlaceholder copy];
    
    //设置文字
    
    self.placeholderLabel.text= myPlaceholder;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}

- (void)setMyPlaceholderColor:(UIColor*)myPlaceholderColor{
    
    _myPlaceholderColor= myPlaceholderColor;
    //_detailTextView.myPlaceholderColor =kColorWithRGB(100, 100, 100);
    myPlaceholderColor=[UIColor lightGrayColor];
    //设置颜色
    
    self.placeholderLabel.textColor= myPlaceholderColor;
}
//重写这个set方法保持font一致

- (void)setFont:(UIFont*)font
{
    
    [super setFont:font];
    
    self.placeholderLabel.font= font;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}


//方法来控制 UILabel 的显示 和 隐藏

- (void)setText:(NSString*)text
{
    
    [super setText:text];
    
    [self textDidChange]; //这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    
}

- (void)setAttributedText:(NSAttributedString*)attributedText
{
    
    [super setAttributedText:attributedText];
    
    [self textDidChange]; //这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    
}
//（六） 最后别忘了销毁 通知


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
    
}


@end
