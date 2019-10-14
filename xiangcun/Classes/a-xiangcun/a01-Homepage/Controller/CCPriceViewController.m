//
//  CCPriceViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCPriceViewController.h"
#import "CCPriceMainTitleView.h"
#import "CCPriceSubTitleView.h"
#import "CCGrayTableViewCell.h"
#import "CCWhiteTableViewCell.h"
#import "CCPriceChoiceViewController.h"

@interface CCPriceViewController (){
    UIView *_redview;

}
@end
@implementation CCPriceViewController

- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
    [self addTitleView];
}


- (void)addTitleView {
    CCPriceMainTitleView *mainTitle = [[NSBundle mainBundle] loadNibNamed:@"CCPriceMainTitleView" owner:nil options:nil].firstObject;;
    if (self.miroFilm) {
        mainTitle.frame = CGRectMake(0, 69.0/667.0*ScreenHeight, ScreenWidth, 40.0/667.0*ScreenHeight);
    }else{
    mainTitle.frame = CGRectMake(0, 114.0/667.0*ScreenHeight, ScreenWidth, 40.0/667.0*ScreenHeight);
    }
    mainTitle.backgroundColor = [UIColor whiteColor];
    
    mainTitle.userInteractionEnabled=YES;
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-65.0/360.0*ScreenWidth, -12.0/667.0*ScreenHeight, 60.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight)];

#pragma mark - 遮盖筛选按钮
    button.backgroundColor=[UIColor whiteColor];
    //[button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [mainTitle addSubview:button];
    
    UIView *view = [[UIView alloc]init];
    
    
    

 
    [self.view addSubview:mainTitle];
    CCPriceSubTitleView *subTitle = [[CCPriceSubTitleView alloc]init];
//    subTitle.frame = CGRectMake(15.0/360.0*ScreenWidth, 104.0/667.0*ScreenHeight, ScreenWidth-20.0/360.0*ScreenWidth, 34.0/667.0*ScreenHeight);
    [self.view addSubview:subTitle];
    
    _priceTableView=[[CCPrinceTableView alloc]init];
    if (self.miroFilm) {
        view.frame=CGRectMake(0.0, 30.0/667.0*ScreenHeight , ScreenWidth, 1.0/667.0*ScreenHeight);
        subTitle.frame = CGRectMake(15.0/360.0*ScreenWidth, 104.0/667.0*ScreenHeight, ScreenWidth-20.0/360.0*ScreenWidth, 34.0/667.0*ScreenHeight);
        _priceTableView.frame=CGRectMake(5.0/360.0*ScreenWidth, 140.0/667.0*ScreenHeight, ScreenWidth-10.0/360.0*ScreenWidth, ScreenHeight-144.0/667.0*ScreenHeight-110.0/667.0*ScreenHeight);
    }else{
        subTitle.frame = CGRectMake(15.0/360.0*ScreenWidth, 195.0/667.0*ScreenHeight, ScreenWidth-20.0/360.0*ScreenWidth, 34.0/667.0*ScreenHeight);
     view.frame=CGRectMake(0.0, 75.0/667.0*ScreenHeight , ScreenWidth, 1.0/667.0*ScreenHeight);
    }
    //priceTableView.bounces=NO;
    //priceTableView.autoresizesSubviews=NO;
    _priceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self drawDashLine:view lineLength:2 lineSpacing:3 lineColor:CCColor(217, 217, 217)];
    [mainTitle addSubview:view];
    [self.view addSubview:_priceTableView];
    
}

-(void)button{
    
    NSLog(@"您正在点击跳转");
    
}



- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [_redview removeFromSuperview];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    if (self.miroFilm) {
        
        
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        _redview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        _redview.userInteractionEnabled=YES;
        _redview.backgroundColor=CCColor(31, 172, 63);;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIButton *btns = [UIButton buttonWithType:UIButtonTypeSystem];
        btns.frame = CGRectMake(18.0/360.0*ScreenWidth, 40.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
        [btns setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btns addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_redview addSubview:btns];
        UILabel *mylable=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-60)/2, 28, 70, 25)];
        mylable.text=@"价格通";
        mylable.textColor=[UIColor whiteColor];
        [_redview addSubview:mylable];
        [window addSubview:_redview];
        
    }
    
}

-(void)back{
    [_redview removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
