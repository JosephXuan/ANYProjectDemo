//
//  CCLabelsTabbar.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/7.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCLabelsTabbar.h"
#import "CCLabelsTabbarCell.h"
#import "CCLabelsTabbarItem.h"
#define ITEM_COUNT                  5
#define SLIDER_HEIGHT               2
#define ID_CELL @"CCLabelsTabbarCell"


@interface CCLabelsTabbar () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,weak) UIView *slider;
@property (nonatomic,weak) UICollectionView *collectionView;

@end
@implementation CCLabelsTabbar
- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] )
    {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat itemw = ScreenWidth / ITEM_COUNT;
    CGFloat itemh = LABELTABBAR_HEIGHT;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemw, itemh);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;

    [collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [collectionView registerClass:[CCLabelsTabbarCell class] forCellWithReuseIdentifier:ID_CELL];
    self.collectionView = collectionView;
    
    UIView *slider = [[UIView alloc] init];
    slider.userInteractionEnabled = NO;
    slider.backgroundColor = AppMainColor;
    [collectionView addSubview:slider];
    CGRect frame = slider.frame;
    frame= CGRectMake(0, LABELTABBAR_HEIGHT - SLIDER_HEIGHT, itemw, SLIDER_HEIGHT);
    slider.frame = frame;
    self.slider = slider;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:kGlobalSeparatorColorStr];
    [self addSubview:line];
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCLabelsTabbarCell *cell = (CCLabelsTabbarCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ID_CELL forIndexPath:indexPath];
    CCLabelsTabbarItem *item = self.items[indexPath.item];
    cell.item = item;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCLabelsTabbarItem *item = self.items[indexPath.item];
    [self updateItemWithIndex:indexPath.item];
    [collectionView reloadData];
    if ( item && [self.delegate respondsToSelector:@selector(labelsTabbar:didSelectedItem:)] )
    {
        [self.delegate labelsTabbar:self didSelectedItem:item];
    }
}

- (void)setSliderIndex:(NSInteger)sliderIndex
{
    if ( sliderIndex != _sliderIndex )
    {
        _sliderIndex = sliderIndex;
        [self adjustSliderToIndex:sliderIndex];
    }
}

- (void)adjustSliderToIndex:(NSInteger)index
{
    CGRect frame = self.slider.frame;
    [self updateItemWithIndex:index];
    frame.origin.x = index * frame.size.width;
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame = frame;
    }];
    [self.collectionView scrollRectToVisible:frame animated:YES];
}

- (void)updateItemWithIndex:(NSInteger)index
{
    CCLabelsTabbarItem *item = self.items[index];
    item.selected = YES;
    for (CCLabelsTabbarItem *subItem in self.items)
    {
        if ( item != subItem  )
        {
            subItem.selected = NO;
        }
    }
    [self.collectionView reloadData];
}

@end
