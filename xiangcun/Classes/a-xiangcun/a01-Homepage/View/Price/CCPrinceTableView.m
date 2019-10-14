//
//  CCPrinceTableView.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/19.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCPrinceTableView.h"
#import "CCGrayTableViewCell.h"
#import "CCWhiteTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"

static NSString *grayPriceCell=@"CCGrayTableViewCell";
static NSString *whitePriceCell=@"CCWhiteTableViewCell";

@interface CCPrinceTableView ()


@property (nonatomic, strong) NSMutableArray *informations;
@property (nonatomic,assign) NSInteger curPage;
@end


@implementation CCPrinceTableView

- (NSMutableArray *)informations {
    if (!_informations) {
        _informations = [NSMutableArray array];
    }
    return _informations;
}


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame style:style]) {
        [self requsetData1];
        self.delegate=self;
        self.dataSource=self;
        
                _curPage = 1;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        [self.mj_header beginRefreshing];
        
        
    }
    return self;
}





-(void)requsetData1{
    
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.pricePass.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *tvPricePass = responseObject[@"tvPricePass"];
        //NSLog(@"价格通单元格＝responseObject==%@",responseObject);
        
        _informations = [CCPriceModel
                         mj_objectArrayWithKeyValuesArray:tvPricePass];
        
        [self reloadData];
        
        _curPage = 2;
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    }];
    
}


-(void)loadNewData{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.pricePass.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : @"1"}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        NSArray *tvPricePass = responseObject[@"tvPricePass"];
        _informations = [CCPriceModel
                         mj_objectArrayWithKeyValuesArray:tvPricePass];
        [self reloadData];
        
        
         //_curPage = 2;
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    }];
}

//------上拉加载更多-----

- (void)loadMoreData {
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"query.pricePass.list", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json", @"pageNo" : [NSString stringWithFormat:@"%zd",_curPage]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
        _curPage ++;
        NSArray *tvPricePass= responseObject[@"tvPricePass"];
        NSArray *dataArr = [CCPriceModel
                            mj_objectArrayWithKeyValuesArray:tvPricePass];
        CCPriceModel *firstModel = [dataArr firstObject];
        CCPriceModel *lastModel = [_informations lastObject];
        CCPriceModel *lastData = [dataArr lastObject];
        if ([firstModel.ids isEqualToString:lastModel.ids]||[lastModel.ids isEqualToString:lastData.ids]) {
            [self.mj_footer endRefreshingWithNoMoreData];
            //[_secondTableView.mj_footer endRefreshing];
            
        } else {
            [_informations addObjectsFromArray:dataArr];
            [self.mj_footer endRefreshing];
        }[self.mj_header endRefreshing];
        [self reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    }];
}





//  tableview代理部分
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.informations.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CCGrayTableViewCell *grayCell=[tableView dequeueReusableCellWithIdentifier:grayPriceCell];
    CCWhiteTableViewCell *whiteCell=[tableView dequeueReusableCellWithIdentifier:whitePriceCell];
    
    if (indexPath.row%2==0) {
        if (grayCell==nil) {
            grayCell=[CCGrayTableViewCell grayCell];
        }
        grayCell.priceModel=_informations[indexPath.row];
        return grayCell;
    }else if(whiteCell==nil){
        whiteCell=[CCWhiteTableViewCell whiteCell];
    }
    whiteCell.priceModel=_informations[indexPath.row];
    return whiteCell;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
