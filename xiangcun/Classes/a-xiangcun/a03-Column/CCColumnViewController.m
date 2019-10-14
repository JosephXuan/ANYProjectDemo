//
//  CCColumnViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCColumnViewController.h"
#import "CCColumnCollectionCell.h"
#import "CCColumnModel.h"
#import "CCPresentViewController.h"
#import "CCBaseNavViewController.h"


@interface CCColumnViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *_controllers;
}


@property (nonatomic, strong) NSMutableArray *columns;

@end

@implementation CCColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title = @"栏目";
    [self addCollectionView];
    _controllers = [NSMutableArray array];
    
    for (int i =0; i<9; i++) {
        CCPresentViewController *ccvc=[[CCPresentViewController alloc]init];
        CCBaseNavViewController *navi = [[CCBaseNavViewController alloc] initWithRootViewController:ccvc];
        
        //navi.titleStr=arr[i];
        
        ccvc.vcTags=i;
        [_controllers addObject:navi];
        
    }

}
- (void)addCollectionView {
    NSArray *titltArray = @[@"新动向",@"大课堂",@"价格通",@"致富经",@"农家游",@"乡村美味",@"新农人",@"农展馆",@"更多"];
    for (NSUInteger i = 0; i < 9; i ++) {
        CCColumnModel *model = [[CCColumnModel alloc]init];
        model.imageName = [NSString stringWithFormat:@"column%u", i + 1];
        model.titleString = titltArray[i];
        [self.columns addObject:model];
        
    }
    

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing=20;
    
    layout.itemSize = CGSizeMake((ScreenWidth - 145.0/360.0*ScreenWidth)/3, (ScreenWidth - 50.0/360.0*ScreenWidth)/3 + 5.0/360.0*ScreenWidth);
    UICollectionView *columnsList = [[UICollectionView alloc]initWithFrame:CGRectMake(35.0/360.0*ScreenWidth, 30.0/667.0*ScreenHeight, ScreenWidth - 70.0/360.0*ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    [self.view addSubview:columnsList];
    columnsList.backgroundColor = [UIColor clearColor];
   [columnsList registerClass:[CCColumnCollectionCell class] forCellWithReuseIdentifier:@"columnCell"];
    columnsList.delegate = self;
    columnsList.dataSource = self;
    columnsList.showsVerticalScrollIndicator = NO;
    columnsList.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:columnsList];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.columns.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
        [self presentViewController:_controllers[indexPath.row] animated:YES completion:nil];




}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CCColumnCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"columnCell" forIndexPath:indexPath];
    CCColumnModel *model = self.columns[indexPath.item];
    cell.columnModel = model;
    return cell;
}
- (NSMutableArray *)columns {
    if (_columns ==nil) {
        _columns = [NSMutableArray array];
    }
    return _columns;
}

//----选中效果，高亮状态----
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    //设置(Highlight)高亮下的颜色
    [cell setBackgroundColor:[UIColor colorWithHexString:@"#838383 "]];
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    //设置(Nomal)正常状态下的颜色
    [cell setBackgroundColor:[UIColor whiteColor]];
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
