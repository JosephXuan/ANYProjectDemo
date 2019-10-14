//
//  CCSearchViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/28.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCSearchViewController.h"
#import "CCAllSearch.h"
@interface CCSearchViewController ()<UITextFieldDelegate>
{
    
}
@property (nonatomic,strong)UITextField *myText;
@end

@implementation CCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(15.0/360.0*ScreenWidth,40.0/667.0*ScreenHeight, 25.0/360.0*ScreenWidth, 27.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_greeenback"] forState:UIControlStateNormal];
    
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self setBaseView];
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(8.0/360.0*ScreenWidth, 68.0/667.0*ScreenHeight , ScreenWidth-16.0/360.0*ScreenWidth, 1)];
//    [self drawDashLine:view lineLength:2 lineSpacing:3 lineColor:CCColor(217, 217, 217)];
//    [self.view addSubview:view];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 20.0/667.0*ScreenHeight)];
    [topView setBackgroundColor:[UIColor colorWithHexString:@"#1ab750"]];
    [self.view addSubview:topView];
    
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)setBaseView{
    UITextField *searchText=[[UITextField alloc]initWithFrame:CGRectMake(45.0/360.0*ScreenWidth, 36.0/667.0*ScreenHeight, 260.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
    searchText.returnKeyType=UIReturnKeySearch;
    searchText.delegate=self;
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(0.0, 16.0/667.0*ScreenHeight, 38.0/360.0*ScreenWidth, 35.0/667.0*ScreenHeight)];
    self.myText=searchText;
   
    
    left.backgroundColor=[UIColor clearColor];
    searchText.leftView=left;
    searchText.leftViewMode=UITextFieldViewModeAlways;
    searchText.placeholder=@"请输入关键词";
    searchText.layer.cornerRadius=5.0/360.0*ScreenWidth;
    searchText.layer.masksToBounds=YES;
    searchText.layer.borderWidth=1;
    searchText.layer.borderColor=[UIColor colorWithHexString:@"#1ab750"].CGColor;
     searchText.clearButtonMode =UITextFieldViewModeWhileEditing;
    [self.view addSubview:searchText];
    
    UIButton *searchButton=[[UIButton alloc]initWithFrame:CGRectMake(10.0/360.0*ScreenWidth , 8.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"nav_sousuo"] forState:UIControlStateNormal];
    [searchText addSubview:searchButton];
    
    UIButton *canceButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-(45.0/360.0*ScreenWidth), 40.0/667.0*ScreenHeight, 40.0/360.0*ScreenWidth, 27.0/667.0*ScreenHeight)];
    
    [canceButton setTitle:@"搜索" forState:UIControlStateNormal];
    [canceButton setTitleColor:[UIColor colorWithHexString:@"#1ab750"] forState:UIControlStateNormal];
    [canceButton.titleLabel setFont:[UIFont systemFontOfSize:16/360.0*ScreenWidth]];
    [canceButton addTarget:self action:@selector(searchInfor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:canceButton];
    
    
    
}

-(void)searchInfor{
    if ([self.myText.text length]<=0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }else{
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.myText.text] forKey:@"searchwords"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"searchword"];
        
        

        
        UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCAllSearch" bundle:nil] instantiateInitialViewController];
        [self presentViewController:SecondController animated:YES completion:nil];
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.myText.text length]<=0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else{
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.myText.text] forKey:@"searchwords"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"searchword"];
        
        
        
        
        UINavigationController *SecondController = [[UIStoryboard storyboardWithName:@"CCAllSearch" bundle:nil] instantiateInitialViewController];
        [self presentViewController:SecondController animated:YES completion:nil];
        
    }
    return YES;
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


//------自定义textfield－－－－
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
    return inset;
    //return CGRectInset(bounds,50,0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
