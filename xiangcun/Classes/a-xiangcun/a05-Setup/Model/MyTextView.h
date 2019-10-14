//
//  MyTextView.h
//  MJLife
//
//  Created by Joseph_Xuan on 16/6/23.
//  Copyright © 2016年 Joseph_Xuan. All rights reserved.
//
//自定义的textview
#import <UIKit/UIKit.h>

@interface MyTextView : UITextView


@property(nonatomic,copy) NSString *myPlaceholder;  //文字

@property(nonatomic,strong) UIColor *myPlaceholderColor; //文字颜色

@property (nonatomic,weak) UILabel *placeholderLabel; //这里先拿出这个label以方便我们后面的使用

@end
