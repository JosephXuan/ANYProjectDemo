//
//  CCFarmTourTableView.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/19.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCFarmTourTableView.h"
#import "CCTourTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CCBaseNavViewController.h"
#import "CCWebViewController.h"

static NSString *tourTableViewCell=@"CCTourTableViewCell";

@interface CCFarmTourTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    CCWebViewController *_webViewController;
    CCTourTableViewCell *_tourCell;
    NSString *_urlString;
}
@end



@implementation CCFarmTourTableView
-(void)setArray:(NSMutableArray *)array{
    if (_array!=array) {
        _array=array;
        
        [self reloadData];
    }
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame style:style]) {
        
        self.delegate=self;
        self.dataSource=self;
        
        
        
        
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
    return self.array.count;

    

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _tourCell=[tableView dequeueReusableCellWithIdentifier:tourTableViewCell];
   
    
    
    
        
        _tourCell=[CCTourTableViewCell nanjingTourCell];
        
    _tourCell.inforModel=self.array[indexPath.row];
    //NSLog(@"单元格里面模型内容%@",_tourCell.inforModel);
        
        return _tourCell;
    
}

#pragma mark －点击跳转详情

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _inforModel=self.array[indexPath.row];
   self.userInteractionEnabled=NO;
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
    
    _webViewController = [[CCWebViewController alloc] init];    _webViewController.url= _inforModel.ids;
    _webViewController.title=@"农家游";
    _webViewController.model=self.detailModel;
    

    [self.nav pushViewController:_webViewController animated:YES];
    
    
    
    
}










@end
