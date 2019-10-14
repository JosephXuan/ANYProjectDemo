//
//  CCLivingViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCLivingViewController.h"
#import <SDCycleScrollView.h>
#import "CCInformationCell.h"
#import "CCInformationModel.h"
#import "CCInformationHeader.h"
#import "MMDrawerBarButtonItem.h"
#import "CCLeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "CCSearchViewController.h"

@interface CCLivingViewController ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *livings;

@end

@implementation CCLivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播";
    [self addCycle];
    [self addCollectionView];
    [self addRightBarButton];
    [self addLeftBarButton];
  //self.clearsSelectionOnViewWillAppear = NO;
    
#pragma mark - 代替展示模块
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight-44.0/667.0*ScreenHeight)];
    bgImage.image=[UIImage imageNamed:@"zhengzaijianshe"];
    [self.view addSubview:bgImage];


}
- (void)addCycle {

     NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg",
                            ];
    NSArray *titles = @[@"生态种养技术，冬季大丰收 ",
                        @"南京农家景点一日游体验",
                        @"促进农业创新和可持续发展",
                        @"中国农业部表示"
                        ];
    SDCycleScrollView *cycleScrollView  = nil;
    if (!self.miroFilm) {
     cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5.0/360.0*ScreenWidth,8.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, 170.0/667.0*ScreenHeight) shouldInfiniteLoop:YES imageNamesGroup:imageNames];

    }else {
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5.0/360.0*ScreenWidth,45.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, 170.0/667.0*ScreenHeight) shouldInfiniteLoop:YES imageNamesGroup:imageNames];

    }

    cycleScrollView.delegate = self;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.titlesGroup = titles;
    self.automaticallyAdjustsScrollViewInsets = NO;
    cycleScrollView.currentPageDotColor = AppMainColor; // 自定义分页控件小圆标颜色
    
    [self.view addSubview:cycleScrollView];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//NSLog(@"---点击了第%ld张图片", (long)index);
    
    //    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

- (void)addCollectionView {
    for (int i = 0; i <4; i ++) {
        CCInformationModel *model = [[CCInformationModel alloc]init];
        model.descriptions = @"今日:12:30直播";
        model.title = @"农产物聊微波干燥试验";
        model.image = @"infomation1.jpg";
        [self.livings addObject:model];
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 40.0/667.0*ScreenHeight);
    
    //layout.sectionInset = UIEdgeInsetsMake(5, 15, 5, 15);
    
    layout.itemSize = CGSizeMake((ScreenWidth - 20.0/360.0*ScreenWidth)/2, (ScreenWidth - 30.0/667.0*ScreenHeight)/2);
    UICollectionView *informationList = nil;
    
    if (self.miroFilm) {
        informationList =   [[UICollectionView alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, 225.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, ScreenHeight - 300.0/667.0*ScreenHeight) collectionViewLayout:layout];

    } else {
        informationList =   [[UICollectionView alloc]initWithFrame:CGRectMake(5.0/360.0*ScreenWidth, 180.0/667.0*ScreenHeight, ScreenWidth - 10.0/360.0*ScreenWidth, ScreenHeight - 300.0/667.0*ScreenHeight) collectionViewLayout:layout];
    }
    [self.view addSubview:informationList];
    informationList.backgroundColor = [UIColor clearColor];
    [informationList registerClass:[CCInformationCell class] forCellWithReuseIdentifier:@"infomationCell"];
    [informationList registerClass:[CCInformationHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"infomationHeader"];
    informationList.delegate = self;
    informationList.dataSource = self;
    informationList.showsVerticalScrollIndicator = NO;
    informationList.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:informationList];
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CCInformationHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"infomationHeader" forIndexPath:indexPath];
        header.inforImage.image = [UIImage imageNamed:@"icon_zhibo"];
        header.titleLabel.text = @"在线直播";
        header.subTitle.text = @"更多直播";
        header.arrowImage.image = [UIImage imageNamed:@"btn_more"];
        return header;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.livings.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CCInformationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"infomationCell" forIndexPath:indexPath];
    CCInformationModel *infomationModel = self.livings[indexPath.item];
    cell.infomationModel = infomationModel;
    return cell;
}

//－－－－左侧菜单栏按钮－－－－－
- (void)addLeftBarButton {
    
    /*
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_caidan"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMenuPage)];
    self.navigationItem.leftBarButtonItem = menuItem;
     */
   
        MMDrawerBarButtonItem *leftButton=[[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(drawController:)];
        UIImage *image=[UIImage imageNamed:@"btn_caidan"];
        
        [leftButton setImage:image];
        [self.navigationItem setLeftBarButtonItem:leftButton animated:YES];
        
     

    
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
    [self presentViewController:history animated:YES completion:nil];}

- (void)gotoMenuPage {
//    CCLeftViewController *left=[[CCLeftViewController alloc]init];
//    
//    [self presentViewController:left animated:YES completion:nil];
    
}
-(void)drawController:(id)sender{
    
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (NSMutableArray *)livings {
    if (_livings == nil) {
        _livings = [NSMutableArray array];
    }
    return _livings;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
