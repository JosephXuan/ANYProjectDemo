//
//  CCClassCollectionView.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/11.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCClassCollectionView.h"
#import "CCClassCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCBaseNavViewController.h"
#import "CCWebViewController.h"

@interface CCClassCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CCWebViewController *_webViewController;
    CCClassCollectionViewCell *_cell;
    NSString *_urlString;
}

@end
static NSString *classCell=@"CCClassCollectionViewCell";

@implementation CCClassCollectionView


-(void)setRightData:(NSMutableArray *)rightData{
    if (_rightData!=rightData) {
        _rightData=rightData;
        
    }
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self=[super initWithFrame:frame collectionViewLayout:layout]) {
        [self setRightData:_rightData];
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}






- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.rightData.count;
    

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
    
    _cell.infomationModel=self.rightData[indexPath.row];
    return _cell;
    
    
    

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _inforModel=self.rightData[indexPath.row];
    self.userInteractionEnabled=NO;
    NSLog(@"你点击了第%ld个cell",(long)indexPath.row) ;
    [self requestCommendDetail];
    
}
-(void)requestCommendDetail{
    
    NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *ids=[dicsLogid objectForKey:@"sessionID"];
    _urlString=[NSString stringWithFormat:@"%@?method=query.article.info&appKey=w4q897jgvxkb&v=1.0&format=json&id=%@&sessionId=%@",KURL,_inforModel.ids,ids];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"请求成功跳转详情＝＝JSON: %@", responseObject);
        _detailModel=[[CCDetailModel alloc]init];
        _detailModel=[CCDetailModel mj_objectWithKeyValues:responseObject];
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"collection"];
        [self setController:responseObject];
        self.userInteractionEnabled=YES;
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}

-(void)setController:(id)responseObject{
    
    _webViewController = [[CCWebViewController alloc] init];
    _webViewController.url= _inforModel.ids;
    _webViewController.title=@"大课堂推荐";
    _webViewController.model=self.detailModel;
    

    [self.nav pushViewController:_webViewController animated:YES];
    
    
    
    
}

@end
