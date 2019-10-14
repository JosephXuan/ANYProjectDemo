//
//  CCSetupViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCSetupViewController.h"
#import "CCSetUpCell.h"
#import "CCSetUpModel.h"
@interface CCSetupViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CCSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = CCColorString(@"#f4f4f4");
    [self addTableView];
}
- (void)addTableView {
    NSArray *titleArray = @[@"清理缓存",@"常见问题",@"意见反馈",@"关于我们"];
    
    for (NSUInteger i = 0; i < 4; i ++) {
        CCSetUpModel *model = [[CCSetUpModel alloc]init];
        model.titleString = titleArray[i];
        [self.dataSource addObject:model];
    }
    
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.backgroundColor = CCColorString(@"#f4f4f4");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 58.0/667.0*ScreenHeight;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.frame = CGRectMake(0, 10.0/667.0*ScreenHeight, ScreenWidth, ScreenHeight);
    [tableView registerClass:[CCSetUpCell class] forCellReuseIdentifier:@"CCSetUpCell"];
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CCSetUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCSetUpCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要清除吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    
    }
        
   if (indexPath.row==1) {
        UINavigationController *history = [[UIStoryboard storyboardWithName:@"QusetionStoryboard" bundle:nil] instantiateInitialViewController];
        [self presentViewController:history animated:YES completion:nil];
    
    }if (indexPath.row==2) {
        
        UINavigationController *history = [[UIStoryboard storyboardWithName:@"BackStoryboard" bundle:nil] instantiateInitialViewController];
        [self presentViewController:history animated:YES completion:nil];
    }if (indexPath.row==3) {
        UINavigationController *history = [[UIStoryboard storyboardWithName:@"AboutUsStoryboard" bundle:nil] instantiateInitialViewController];
        [self presentViewController:history animated:YES completion:nil];

    }
    
    
    
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
