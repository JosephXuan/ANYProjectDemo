//
//  GuideController.m
//  zuileme
//
//  Created by jiuyi on 16/9/17.
//  Copyright © 2016年 Hefei JiuYi Network Technology Co.,Ltd. All rights reserved.
//

#import "GuideController.h"
#import "AppDelegate.h"

@interface GuideController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *imgsArr;

@end

@implementation GuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScroll];
}

- (void)setupScroll {
    
    for (int i = 0; i < self.imgsArr.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight)];
        imageView.image = [UIImage imageNamed:self.imgsArr[i]];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
    }
    
    UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(ScreenWidth * 3, 0, ScreenWidth, ScreenHeight)];
    [self.scrollView addSubview:control];
    [control addTarget:self action:@selector(controlAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * self.imgsArr.count, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)controlAction {
    
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDele setUpAppHomeController];
}

- (NSArray *)imgsArr {
    
    if (!_imgsArr) {
        _imgsArr = @[@"step1.jpg",@"step2.jpg",@"step3.jpg",@"step4.jpg"];
    }
    return _imgsArr;
}

@end
