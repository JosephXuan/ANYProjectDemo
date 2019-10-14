//
//  CCPresentViewController.m
//  xiangcun
//
//  Created by Joseph_Xuan on 16/9/24.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCPresentViewController.h"
#import "CCNewTrendViewController.h"
#import "CCClassroomViewController.h"
#import "CCPriceViewController.h"
#import "CCRichViewController.h"
#import "CCFarmTourViewController.h"
#import "CCNewFarmerViewController.h"
#import "CCMicroFilmViewController.h"
#import "CCExhibitionViewController.h"
#import "otherViewController.h"
#import "CCLivingViewController.h"

@interface CCPresentViewController ()

@end

@implementation CCPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    if (_VCcontrollers==nil) {
        _VCcontrollers=[NSMutableArray array];
    }
    NSArray *arr=@[@"新动向",@"大课堂",@"价格通",@"致富经",@"农家游",@"乡村美味",@"新农人",@"农展馆",@"更多"];
    if (_vcTags==0) {
        CCNewTrendViewController *newThred=[[CCNewTrendViewController alloc]init];
        self.title=arr[_vcTags];
        [self addChildViewController:newThred];
        [self.view addSubview:newThred.view];
    }
    if (_vcTags==1) {
         CCClassroomViewController *classroom=[[CCClassroomViewController alloc]init];
        classroom.view.frame=CGRectMake(0, -38, ScreenWidth, ScreenHeight+43);
        self.title=arr[_vcTags];
        [self addChildViewController:classroom];
        [self.view addSubview:classroom.view];
    }
    if (_vcTags==2) {
         CCPriceViewController *price=[[CCPriceViewController alloc]init];
        price.view.frame=CGRectMake(0, -38, ScreenWidth, ScreenHeight+43);
        price.priceTableView.frame=CGRectMake(5.0/360.0*ScreenWidth, 230.0/667.0*ScreenHeight, ScreenWidth-10.0/360.0*ScreenWidth, ScreenHeight-144.0/667.0*ScreenHeight-40.0/667.0*ScreenHeight);
        self.title=arr[_vcTags];
        [self addChildViewController:price];
        [self.view addSubview:price.view];
    }
    if (_vcTags==3) {
        CCRichViewController *rich=[[CCRichViewController alloc]init];
        rich.view.frame=CGRectMake(0, -38, ScreenWidth, ScreenHeight+43);
        rich.rich.frame= CGRectMake(0.0, 92.0/667.0*ScreenHeight, ScreenWidth, ScreenHeight-50.0/667.0*ScreenHeight);
        self.title=arr[_vcTags];
        [self addChildViewController:rich];
        [self.view addSubview:rich.view];
    }
    if (_vcTags==4) {
        CCFarmTourViewController *farmTour=[[CCFarmTourViewController alloc]init];
        farmTour.view.frame=CGRectMake(0, -38, ScreenWidth, ScreenHeight+43);
        self.title=arr[_vcTags];
        [self addChildViewController:farmTour];
        [self.view addSubview:farmTour.view];
    }
    if (_vcTags==5) {
        

        
        CCMicroFilmViewController *mFilm=[[CCMicroFilmViewController alloc]init];
        mFilm.view.frame=CGRectMake(0, -38, ScreenWidth, ScreenHeight);

        self.title=arr[_vcTags];
        [self addChildViewController:mFilm];
        [self.view addSubview:mFilm.view];
            }
    if (_vcTags==6) {
                
        
        CCNewFarmerViewController *newFarm=[[CCNewFarmerViewController alloc]init];
        
        newFarm.view.frame=CGRectMake(0, -38, ScreenWidth, ScreenHeight+43);
        newFarm.rich.frame= CGRectMake(0.0, 92.0/667.0*ScreenHeight, ScreenWidth, ScreenHeight-50.0/667.0*ScreenHeight);
        self.title=arr[_vcTags];
                [self addChildViewController:newFarm];
                [self.view addSubview:newFarm.view];
                
          
    }
    if (_vcTags==7) {
        CCExhibitionViewController *exhibition=[[CCExhibitionViewController alloc]init];
        exhibition.view.frame=CGRectMake(0, 25, ScreenWidth, ScreenHeight);
//        exhibition.exihibitioning.frame=CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+62.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight);
        exhibition.nowTableView.frame=CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+22.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight);
        exhibition.histroyTableView.frame=CGRectMake(90.0/360.0*ScreenWidth, ScreenHeight-(ScreenHeight-275.0/667.0*ScreenHeight)+22.0/667.0*ScreenHeight, ScreenWidth-90.0/360.0*ScreenWidth, ScreenHeight);
        self.title=arr[_vcTags];
        [self addChildViewController:exhibition];
        [self.view addSubview:exhibition.view];
    }
    if (_vcTags==8) {
        otherViewController *other=[[otherViewController alloc]init];
        other.view.frame=CGRectMake(0, -38, ScreenWidth, ScreenHeight+43);
        self.title=arr[_vcTags];
        [self addChildViewController:other];
        [self.view addSubview:other.view];
    }
    
    
    
    
   
   
    
    
    
  
    
    
//    [_VCcontrollers addObject:newThred];
//    [_VCcontrollers addObject:classroom];
//    [_VCcontrollers addObject:price];
//    [_VCcontrollers addObject:rich];
//    [_VCcontrollers addObject:farmTour];
//    [_VCcontrollers addObject:newFarm];
//    [_VCcontrollers addObject:mFilm];
//    [_VCcontrollers addObject:exhibition];
    
  
   

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
