//
//  CCLineViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/11/14.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCLineViewController.h"
#import "CCRoadLineTableViewCell.h"


@interface CCLineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_endName;
    CCRoadLineTableViewCell *_roadLine;
}
@end

@implementation CCLineViewController

-(void)setArrays:(NSMutableArray *)arrays{
    if (_arrays!=arrays) {
        _arrays=arrays;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"路线详情";
    NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"NZGdetail"];
    NSString *name=[dics objectForKey:@"name"];
    _endName=name;
    self.view.backgroundColor=[UIColor whiteColor];
//    NSLog(@"%@",_arrays);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0,0.0, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self setBaseView];
    
    
    
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setBaseView{

    UILabel *myLocation=[[UILabel alloc]initWithFrame:CGRectMake(30.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight, 70.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight)];
    myLocation.text=@"我的位置";
    myLocation.font=[UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    myLocation.textColor=[UIColor colorWithHexString:@"#1ab750"];
    [self.view addSubview:myLocation];
    
    
    
    UIImageView *decrition=[[UIImageView alloc]initWithFrame:CGRectMake(103.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight, 15.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight)];
    decrition.image=[UIImage imageNamed:@"jiacheluxian_jiantou"];
    [self.view addSubview:decrition];
    
    
    UILabel *endLocation=[[UILabel alloc]initWithFrame:CGRectMake(121.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight, 200.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight)];
    endLocation.text=_endName;
    endLocation.font=[UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    endLocation.textColor=[UIColor colorWithHexString:@"#1ab750"];
    [self.view addSubview:endLocation];
    
    UILabel *timeLable=[[UILabel alloc]initWithFrame:CGRectMake(30.0/360.0*ScreenWidth, 41.0/667.0*ScreenHeight, 280.0/360.0*ScreenWidth, 16.0/667.0*ScreenHeight)];
    NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"lineTime"];
    NSString *time=[dics objectForKey:@"time"];
    
    NSDictionary *dics2=[[NSUserDefaults standardUserDefaults]objectForKey:@"lineDistance"];
    NSString *distance=[dics2 objectForKey:@"distance"];
    timeLable.text=[NSString stringWithFormat:@"全程约%@分钟／%@公里",time,distance];
    timeLable.font=[UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    timeLable.textColor=[UIColor colorWithHexString:@"#a9a9a9"];
    [self.view addSubview:timeLable];
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(30.0/360.0*ScreenWidth, 66.0/667.0*ScreenHeight, (ScreenWidth-45.0/360.0*ScreenWidth), 1.0/667.0*ScreenHeight)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#cdcdcd"];
    [self.view addSubview:lineView];
    
    UIImageView *startImage=[[UIImageView alloc]initWithFrame:CGRectMake(30.0/360.0*ScreenWidth, 80.0/667.0*ScreenHeight,25.0/360.0*ScreenWidth, 25.0/360.0*ScreenWidth)];
    startImage.image=[UIImage imageNamed:@"icon_qidian"];
    [self.view addSubview:startImage];
    
    UILabel *start=[[UILabel alloc]initWithFrame:CGRectMake(80.0/360.0*ScreenWidth, 80.0/667.0*ScreenHeight,250.0/360.0*ScreenWidth, 25.0/667.0*ScreenHeight)];
    start.font=[UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
   start.text=_start;;
    start.textColor=[UIColor colorWithHexString:@"#1ab750"];
    [self.view addSubview:start];
    
    
    UITableView *roadLine=[[UITableView alloc]initWithFrame:CGRectMake(40.0/360.0*ScreenWidth, 131.0/667.0*ScreenHeight,ScreenWidth-80.0/360.0*ScreenWidth, ScreenHeight-362.0/667.0*ScreenHeight)];
    roadLine.backgroundColor=[UIColor whiteColor];
    roadLine.delegate=self;
    roadLine.dataSource=self;
    roadLine.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:roadLine];
    
    UIImageView *endImage=[[UIImageView alloc]initWithFrame:CGRectMake(30.0/360.0*ScreenWidth, 460.0/667.0*ScreenHeight,25.0/360.0*ScreenWidth, 25.0/360.0*ScreenWidth)];
    endImage.image=[UIImage imageNamed:@"icon_zhongdian"];
    [self.view addSubview:endImage];
    
    UILabel *end=[[UILabel alloc]initWithFrame:CGRectMake(80.0/360.0*ScreenWidth, 460.0/667.0*ScreenHeight,250.0/360.0*ScreenWidth, 25.0/667.0*ScreenHeight)];
    end.font=[UIFont systemFontOfSize:16.0/360.0*ScreenWidth];
    end.text=_endName;
    end.textColor=[UIColor colorWithHexString:@"#1ab750"];
    [self.view addSubview:end];
}


#pragma mark - //tableview代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0/667.0*ScreenHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arrays.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *id=@"CCRoadLineTableViewCell";
    _roadLine=[tableView dequeueReusableCellWithIdentifier:id];
    
    if (_roadLine==nil) {
        
        _roadLine=[[CCRoadLineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
        
    }
    
    _roadLine.title.text=_arrays[indexPath.row];

    
    return _roadLine;
    
    
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
