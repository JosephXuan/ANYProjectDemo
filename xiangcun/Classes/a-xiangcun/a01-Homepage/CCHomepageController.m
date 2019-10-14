//
//  CCHomepageController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCHomepageController.h"
#import "CCHomePageBaseViewController.h"
#import "CCLabelsTabbarItem.h"
#import "CCNewTrendViewController.h"
#import "CCClassroomViewController.h"
#import "CCPriceViewController.h"
#import "CCRichViewController.h"
#import "CCFarmTourViewController.h"
#import "CCNewFarmerViewController.h"
#import "CCMineViewController.h"
#import "CCExhibitionViewController.h"
#import "CCMicroFilmViewController.h"
#import "CCLabelsTabbar.h"
#import "CCLabelsTabbarItem.h"
#import "CCLivingViewController.h"
#import "CCNewTrendViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "CCLeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "AppDelegate.h"
#import "CCSearchViewController.h"
#import "CCHistoryViewController.h"

@interface CCHomepageController ()<CCLabelsTabbarDelegate,UIScrollViewDelegate>
@property (nonatomic,weak) CCLabelsTabbar *labelTabbar;
@property (nonatomic, assign) NSInteger currpage;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) CCHomePageBaseViewController *currVC;


@end

@implementation CCHomepageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *title = [[UILabel alloc] init];
    title.text = @"爱农易";
    title.font = [UIFont systemFontOfSize:17.0/360.0*ScreenWidth];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    CGSize leftLabSize =[title.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0/360.0*ScreenWidth]}];
    title.frame=CGRectMake(0, 0, leftLabSize.width, leftLabSize.height);
    self.navigationItem.titleView = title;
    [self setUpChildViewController];
    
    [self setupBaseView];
    self.currpage =0;
    [self addRightBarButton];
    [self addLeftBarButton];
    
}




- (void)addLeftBarButton {
    
    
        MMDrawerBarButtonItem *leftButton=[[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(drawController:)];
        UIImage *image=[UIImage imageNamed:@"btn_caidan"];
        
        [leftButton setImage:image];
        [self.navigationItem setLeftBarButtonItem:leftButton animated:YES];
     
    
}

/*
- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    return [[AppDelegate globalDelegate] drawerAnimator];
}
*/

-(void)drawController:(id)sender{
    
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)addRightBarButton {

    UIBarButtonItem *searchBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_sousuo"] style:UIBarButtonItemStylePlain target:self action:@selector(goToSearchPage)];
    UIBarButtonItem *historyBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_lishi"] style:UIBarButtonItemStylePlain target:self action:@selector(goToHistoryPage)];
    self.navigationItem.rightBarButtonItems = @[historyBtnItem, searchBtnItem];

}
- (void)goToSearchPage {
    
    CCSearchViewController *search=[[CCSearchViewController alloc]init];
    [self presentViewController:search animated:YES completion:nil];
    

    
}
- (void)goToHistoryPage {
    
   
    UINavigationController *history = [[UIStoryboard storyboardWithName:@"HistorySearchStoryboard" bundle:nil] instantiateInitialViewController];
    [self presentViewController:history animated:YES completion:nil];
}

//---------抽屉视图按钮---

- (void)gotoMenuPage {
    //[[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

- (void)setupBaseView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    [contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.view bringSubviewToFront:self.labelTabbar];
    
//-----把所有的控制器添加到一张大的scrollerview上实现滑动
    UIScrollView *scrollView = [[UIScrollView alloc] init];
//-----滑动的时候隐藏滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [contentView addSubview:scrollView];
    scrollView.frame = self.view.bounds;
    [scrollView setContentSize:CGSizeMake(self.labelTabbar.items.count * self.view.bounds.size.width, 0)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    self.scrollView = scrollView;
        
}

- (void)setUpChildViewController
{
    NSMutableArray *items = [NSMutableArray array];
    
    CCLabelsTabbarItem *newTrendItem = [[CCLabelsTabbarItem alloc]init];
    newTrendItem.title = @"新动向";
    newTrendItem.selected = YES;
    newTrendItem.index = 0;
    CCNewTrendViewController *newTrendVC = [[CCNewTrendViewController alloc]init];
    newTrendVC.miroFilm=YES;
    newTrendVC.viewControllerItem = newTrendItem;
    newTrendVC.title = newTrendItem.title;
    [self addChildViewController:newTrendVC];
    [items addObject:newTrendItem];
    
    
    
    CCLabelsTabbarItem *classroomItem = [[CCLabelsTabbarItem alloc]init];
    classroomItem.title = @"大课堂";
    classroomItem.index = 1;
    CCClassroomViewController *classroomVC = [[CCClassroomViewController alloc]init];
    classroomVC.miroFilm=YES;
    classroomVC.viewControllerItem = classroomItem;
    classroomVC.title = classroomItem.title;
    [self addChildViewController:classroomVC];
    [items addObject:classroomItem];
    
    
    CCLabelsTabbarItem *priceItem = [[CCLabelsTabbarItem alloc]init];
    priceItem.title = @"价格通";
    priceItem.index = 2;
    CCPriceViewController *priceVC = [[CCPriceViewController alloc]init];
    priceVC.miroFilm=YES;
    priceVC.viewControllerItem = priceItem;
    priceVC.title = priceItem.title;
    [self addChildViewController:priceVC];
    [items addObject:priceItem];
    
    
    CCLabelsTabbarItem *richItem = [[CCLabelsTabbarItem alloc]init];
    richItem.title = @"致富经";
    richItem.index = 3;
    CCRichViewController *richVC = [[CCRichViewController alloc]init];
    richVC.miroFilm=YES;
    richVC.viewControllerItem = richItem;
    richVC.title = richItem.title;
    [self addChildViewController:richVC];
    [items addObject:richItem];
    
    
    CCLabelsTabbarItem *farmTourItem = [[CCLabelsTabbarItem alloc]init];
    farmTourItem.title = @"农家游";
    farmTourItem.index = 4;
    CCFarmTourViewController *farmTourVC = [[CCFarmTourViewController alloc]init];
    farmTourVC.miroFilm=YES;
    farmTourVC.viewControllerItem = farmTourItem;
    farmTourVC.title = farmTourItem.title;
    [self addChildViewController:farmTourVC];
    [items addObject:farmTourItem];
    
    
    
    CCLabelsTabbarItem *microFilmItem = [[CCLabelsTabbarItem alloc]init];
    microFilmItem.title = @"乡村美味";
    microFilmItem.index = 5;
    
    
//==============此处控制器初始化错误===========
    
     CCMicroFilmViewController*microFilmVC = [[CCMicroFilmViewController alloc]init];
    microFilmVC.miroFilm = YES;
    microFilmVC.viewControllerItem = microFilmItem;
    microFilmVC.title = microFilmItem.title;
    [self addChildViewController:microFilmVC];
    [items addObject:microFilmItem];
    
    
    CCLabelsTabbarItem *newFarmerItem = [[CCLabelsTabbarItem alloc]init];
    newFarmerItem.title = @"新农人";
    newFarmerItem.index = 6;
    
    CCNewFarmerViewController *newFarmerVC = [[CCNewFarmerViewController alloc]init];
    newFarmerVC.miroFilm=YES;
    newFarmerVC.viewControllerItem = newFarmerItem;
    newFarmerVC.title = newFarmerItem.title;
    [self addChildViewController:newFarmerVC];
    [items addObject:newFarmerItem];
    
    
    CCLabelsTabbarItem *exhibitionItem = [[CCLabelsTabbarItem alloc]init];
    exhibitionItem.title = @"农展馆";
    exhibitionItem.index = 7;
    CCExhibitionViewController *exhibitionVC = [[CCExhibitionViewController alloc]init];
    
    exhibitionVC.exihibition=YES;
    exhibitionVC.viewControllerItem = exhibitionItem;
    exhibitionVC.title = exhibitionItem.title;
    [self addChildViewController:exhibitionVC];
    [items addObject:exhibitionItem];

    CCLabelsTabbar *labelTabbar = [[CCLabelsTabbar alloc] init];
    labelTabbar.delegate = self;
    [self.view addSubview:labelTabbar];
    [labelTabbar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [labelTabbar autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [labelTabbar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [labelTabbar autoSetDimension:ALDimensionHeight toSize:LABELTABBAR_HEIGHT];
    labelTabbar.items = items;
    self.labelTabbar = labelTabbar;


    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    for ( CCHomePageBaseViewController *item  in self.childViewControllers )
    {
        if ( !item.viewControllerItem.viewLoadFinish || item == self.currVC )
        {
            continue;
        }
        else
        {
            [item viewWillDisappear:animated];
        }
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for ( CCHomePageBaseViewController *item  in self.childViewControllers )
    {
        if ( !item.viewControllerItem.viewLoadFinish || item == self.currVC )
        {
            continue;
        }
        else
        {
            [item viewDidDisappear:animated];
        }
    }
}
- (void)setCurrpage:(NSInteger)currpage
{
    
    CCHomePageBaseViewController *preVC= self.currVC;
    
      [preVC viewWillDisappear:YES];
    
         _currpage = currpage;
    
    CCHomePageBaseViewController *vc = self.childViewControllers[currpage];
    
    if ( !vc.viewControllerItem.viewLoadFinish )
    {
        CGFloat x = currpage * self.view.bounds.size.width;
        vc.view.frame = CGRectMake(x, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
        [self.scrollView addSubview:vc.view];
        vc.viewControllerItem.viewLoadFinish = YES;
    }
    else
    {
        [vc viewWillAppear:YES];
    }
    
    self.labelTabbar.sliderIndex = currpage;
    self.currVC = vc;
    
    if ( !vc.viewControllerItem.viewLoadFinish )
    {
        [vc viewDidAppear:YES];
    }
    
    [preVC viewDidDisappear:YES];
}
#pragma mark - CCLabelsTabbarDelegate
- (void)labelsTabbar:(CCLabelsTabbar *)tabbar didSelectedItem:(CCLabelsTabbarItem *)item
{
    if ( item.index != self.currpage )
    {
        CGPoint offset = CGPointMake( self.scrollView.bounds.size.width * item.index , 0);
        [self.scrollView setContentOffset:offset animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate  //滑动视图代理
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    if ( page != self.currpage )
    {
        self.currpage = page;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    if ( page != self.currpage )
    {
        self.currpage = page;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
