//
//  CCChangeInforViewController.m
//  xiangcun
//
//  Created by 李孝帅 on 16/10/17.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "CCChangeInforViewController.h"
#import "CCBaseNavViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "CCChangePasViewController.h"
@interface CCChangeInforViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *_myHeadPortrait;
    NSString *_nickNames;
    NSString *_photoSTr;
    NSString *_imageURL;
    NSInteger _loginSuccess;
    NSString *_memberID;
    NSInteger _loginOutSuccess;
    NSInteger _success;
    NSInteger _namesuccess;
    UIButton *_userName;
}
@property (nonatomic,strong)UIImageView *myHeadPortrait;
@property (nonatomic,strong)UILabel *rightLable;
@property (nonatomic,strong)UITextField *nickNamed;
@end



@implementation CCChangeInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CCColorString(@"#f4f4f4");
[self setBaseView];
    
#pragma  mark - 修改用户昵称
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
    _nickNames=[dic objectForKey:@"nickName"];
    
    
#pragma  mark - 修改用户头像
    NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
    _imageURL=[dics objectForKey:@"headPortrait"];
    
//NSLog(@"%@",_imageURL);
#pragma  mark - 获取用户id，用于退出
       NSDictionary *dicsLogid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    _memberID=[dicsLogid objectForKey:@"sessionID"];
    
#pragma  mark -用于判断用户是否退出
    NSDictionary *dicsLogOut=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginOutDic"];
    NSString*loginOutSuccess=[dicsLogOut objectForKey:@"successful"];
    _loginOutSuccess=loginOutSuccess.integerValue;
    NSDictionary *dicss=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
    
    NSString*success=[dicss objectForKey:@"successful"];
    _success=success.integerValue;
    NSDictionary *namedicss=[[NSUserDefaults standardUserDefaults]objectForKey:@"userNickName"];
    
    NSString*namesuccess=[namedicss objectForKey:@"successful"];
    _namesuccess=namesuccess.integerValue;
    
   // self.rightLable.text=_nickNames;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"localName"];
    _nickNames=[dic objectForKey:@"name"];
    
    
    self.rightLable.text=_nickNames;
    
    NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
    _imageURL=[dics objectForKey:@"headPortrait"];
    // NSLog(@"_imageURL222=＝%@",_imageURL);
    
    if (_loginOutSuccess==1) {
        self.myHeadPortrait.image=[UIImage imageNamed:@"log"];
    }
    if (_success==0) {
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
        NSString *personImg=[dics objectForKey:@"headPortrait"];
        [self.myHeadPortrait sd_setImageWithURL:[NSURL URLWithString:personImg] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
    }else if (_success==1){
        //NSLog(@"图片链接%@",_imageURL);
        [self.myHeadPortrait sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
    }
    if (_namesuccess==0) {
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
        _nickNames=[dics objectForKey:@"nickName"];
        self.rightLable.text=_nickNames;
    }else if (_namesuccess==0){
        
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"localName"];
        _nickNames=[dics objectForKey:@"name"];
        self.rightLable.text=_nickNames;
    }
    
   
    
}

-(void)setBaseView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10.0/360.0*ScreenWidth, 20.0/667.0*ScreenHeight, 20.0/360.0*ScreenWidth, 18.0/667.0*ScreenHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#"]];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
#pragma mark - 修改头像
    UIButton *userImage=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 5.0/667.0*ScreenHeight, ScreenWidth, 55.0/667.0*ScreenHeight)];
    [userImage addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    userImage.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:userImage];
    
    UILabel *userLable=[[UILabel alloc]initWithFrame:CGRectMake(22.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-15.0/667.0*ScreenHeight)/2, 60.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    
    userLable.text=@"头像";
    [userImage addSubview:userLable];
    
    UIImageView *myHeadPortrait=[[UIImageView alloc]initWithFrame:CGRectMake(304.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-40.0/667.0*ScreenHeight)/2, 40.0/667.0*ScreenHeight, 40.0/667.0*ScreenHeight)];
    myHeadPortrait.layer.cornerRadius=20.0/667.0*ScreenHeight;
    myHeadPortrait.layer.masksToBounds=YES;
    myHeadPortrait.backgroundColor=[UIColor redColor];
    self.myHeadPortrait=myHeadPortrait;
    if (_success==1) {
        [self.myHeadPortrait sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
    }else if (_success==0){
        [self.myHeadPortrait sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
    }

    
    
    
    [userImage addSubview:myHeadPortrait];
    
#pragma mark - 修改昵称
    UIButton *userName=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 65.0/667.0*ScreenHeight, ScreenWidth, 55.0/667.0*ScreenHeight)];
    userName.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:userName];
    [userName addTarget:self action:@selector(changeNiceName) forControlEvents:UIControlEventTouchUpInside];
    UILabel *userNameLable=[[UILabel alloc]initWithFrame:CGRectMake(22.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-15.0/667.0*ScreenHeight)/2, 60.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    
    userNameLable.text=@"昵称";
    [userName addSubview:userNameLable];
    
    UILabel *rightLable=[[UILabel alloc]initWithFrame:CGRectMake(223.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-25.0/667.0*ScreenHeight)/2, 100.0/360.0*ScreenWidth, 25.0/667.0*ScreenHeight)];
    rightLable.textAlignment=NSTextAlignmentCenter;
    rightLable.text=@"爱农易";
    self.rightLable=rightLable;
    if (_namesuccess==0) {
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfor"];
        _nickNames=[dics objectForKey:@"nickName"];
        self.rightLable.text=_nickNames;
    }else if (_namesuccess==0){
        
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"localName"];
        _nickNames=[dics objectForKey:@"name"];
        self.rightLable.text=_nickNames;
        
    }
    [userName addSubview:rightLable];
    
    UIImageView *bac=[[UIImageView alloc]initWithFrame:CGRectMake(329.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-20.0/667.0*ScreenHeight)/2, 10.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    bac.image=[UIImage imageNamed:@"mine_in"];
    [userName addSubview:bac];
    
#pragma mark - 修改密码
    UIButton *passWord=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 125.0/667.0*ScreenHeight, ScreenWidth, 55.0/667.0*ScreenHeight)];
    passWord.backgroundColor=[UIColor whiteColor];
    [passWord addTarget:self action:@selector(changPas) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passWord];
    
    UILabel *passNameLable=[[UILabel alloc]initWithFrame:CGRectMake(22.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-15.0/667.0*ScreenHeight)/2, 100.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    
    passNameLable.text=@"修改密码";
    [passWord addSubview:passNameLable];
    
    
    
    UIImageView *bac2=[[UIImageView alloc]initWithFrame:CGRectMake(329.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-15.0/667.0*ScreenHeight)/2, 10.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    bac2.image=[UIImage imageNamed:@"mine_in"];
    [passWord addSubview:bac2];
    
#pragma mark - 修改密码
    UIButton *phoneNum=[[UIButton alloc]initWithFrame:CGRectMake(0.0, 185.0/667.0*ScreenHeight, ScreenWidth, 55.0/667.0*ScreenHeight)];
    phoneNum.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:phoneNum];
    
    UILabel *phoneNumLable=[[UILabel alloc]initWithFrame:CGRectMake(22.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-15.0/667.0*ScreenHeight)/2, 100.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    
    phoneNumLable.text=@"手机号";
    [phoneNum addSubview:phoneNumLable];
    
    
    
    UILabel *rightLable3=[[UILabel alloc]initWithFrame:CGRectMake(230.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-15.0/667.0*ScreenHeight)/2, 100.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    rightLable3.text=@"绑定手机号";
    [phoneNum addSubview:rightLable3];
    
    
    UIImageView *bac3=[[UIImageView alloc]initWithFrame:CGRectMake(329.0/360.0*ScreenWidth, (55.0/667.0*ScreenHeight-15.0/667.0*ScreenHeight)/2, 10.0/360.0*ScreenWidth, 15.0/667.0*ScreenHeight)];
    bac3.image=[UIImage imageNamed:@"mine_in"];
    [phoneNum addSubview:bac3];
    
    
    UIButton *tuichuLogin=[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-107.0/360.0*ScreenWidth)/2, 505.0/667.0*ScreenHeight, 107.0/360.0*ScreenWidth, 34.0/667.0*ScreenHeight)];
    [tuichuLogin setTitle:@"退出登录" forState:UIControlStateNormal];
    
    [tuichuLogin addTarget:self action:@selector(tcAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [tuichuLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tuichuLogin.backgroundColor=[UIColor colorWithHexString:@"#f5c931"];
    tuichuLogin.layer.cornerRadius=10.0/360.0*ScreenWidth;
    tuichuLogin.layer.masksToBounds=YES;
    [self.view addSubview:tuichuLogin];
    
}

-(void)changeNiceName{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert ];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.placeholder = @"请输入昵称";
        self.nickNamed=textField;
  
    }];
    [self presentViewController:alertController animated:YES completion:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        if ([self.nickNamed.text isEqualToString:@""]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称不能为空，请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }else{
        self.rightLable.text=self.nickNamed.text;
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.nickNamed.text] forKey:@"name"];
        
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"localName"];
        
        [self sendNickName];

        }
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (self.nickNamed.text==nil) {
            NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"localName"];
            _nickNames=[dic objectForKey:@"name"];
            
            
            self.rightLable.text=_nickNames;
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
    }]];
    
}

-(void)sendNickName{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [ AFHTTPRequestSerializer serializer ];
    manager.responseSerializer =[ AFHTTPResponseSerializer serializer ];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" :@"member.edit.nickName",@"appKey" :@"w4q897jgvxkb",@"v" :@"1.0", @"format" : @"json",@"sessionId": [NSString stringWithFormat:@"%@",_memberID], @"nickName" : [NSString stringWithFormat:@"%@",self.nickNamed.text]}];
    [manager POST:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
        // NSArray *article = responseObject[@""];
        //NSLog(@"提交昵称－%@",responseObject);
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
        
        
        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //------------字符串再生成NSData
        
        NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
        
        //------------再解析
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        [[NSUserDefaults standardUserDefaults]setObject:jsonDict forKey:@"userNickName"];
        NSDictionary *nameDic=[[NSUserDefaults standardUserDefaults]objectForKey:@"userNickName"];
        NSString *name=[nameDic objectForKey:@"nickName"];
        NSLog(@"昵称是＝＝＝＝%@",name);
        
        
        NSLog(@"result===%@",result);
        NSLog(@"jsonDict===%@",jsonDict);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];

    
    
}

-(void)changPas{
    CCChangePasViewController *changePas=[[CCChangePasViewController alloc]init];
    [self.navigationController pushViewController:changePas animated:YES];
    
}

-(void)tcAction{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginDic"];
   //NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  //  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"memberInfor"];
    //NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
  
    [self requsetUnload];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)requsetUnload{
    NSURL *URL = [NSURL URLWithString:KURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.logout", @"appKey" : @"w4q897jgvxkb", @"v" : @"1.0", @"format" : @"json",@"sessionId": [NSString stringWithFormat:@"%@",_memberID]}];
    [manager GET:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
               NSLog(@"退出登录成功返回数据－%@",responseObject);

        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"loginOutDic"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退出登录成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];

                [self dismissViewControllerAnimated:YES completion:nil];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}


-(void)changeImage{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
       
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc]init];
  
//获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
//获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
//获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        pickerImage.allowsEditing = YES;
        //自代理
        pickerImage.delegate = self;
        //页面跳转
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *pickerImage2 = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        pickerImage2.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerImage2.allowsEditing = YES;
        pickerImage2.delegate = self;
        [self presentViewController:pickerImage2 animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}




//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *oldPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
   self.myHeadPortrait.image = oldPhoto;
    
    CGFloat compression =0.9f;
    CGFloat minCompression =0.01;
    
    float scale=0.1;
   
   
    NSData *data = UIImageJPEGRepresentation(oldPhoto, compression);
    
    NSData * newImageData =UIImageJPEGRepresentation(oldPhoto, 1);
        while ((compression >minCompression)&&(data.length>0.01)) {
        data=UIImageJPEGRepresentation(oldPhoto, compression);
        
        UIImage *compressedImage=[UIImage imageWithData:data];
        
        newImageData=UIImageJPEGRepresentation(compressedImage, 1);
        compression-=scale;
        
        
    }
    UIImage *compressedImage=[UIImage imageWithData:newImageData];

    
    NSData *newData=UIImageJPEGRepresentation(compressedImage, .5f);
    
    NSString *base64= [newData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
   

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURL *URL = [NSURL URLWithString:KURL];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html",@"application/xml" ,nil];
   
    
   

#pragma mark - 判断是否登录
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    NSString *sessionIds=[dic objectForKey:@"sessionID"];
    
    
    _photoSTr=[NSString stringWithFormat:@"png@%@",base64];
    NSLog(@"转换后的字符串%@",_photoSTr);
    NSLog(@"sessionID＝＝%@",sessionIds);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"method" : @"member.upload.headPortrait",@"appKey" : @"w4q897jgvxkb",@"v":@"1.0",@"format": @"json",@"sessionId":[NSString stringWithFormat:@"%@",sessionIds],@"photo":[NSString stringWithFormat:@"%@",_photoSTr]}];
    
    [manager POST:URL.absoluteString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"会员上传头像返回数据－%@",responseObject);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功上传头像，感谢支持" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
       
        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//------------字符串再生成NSData
        
        NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
        
//------------再解析
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [[NSUserDefaults standardUserDefaults]setObject:jsonDict forKey:@"memberInfor"];
        
        
        
        NSDictionary *dics=[[NSUserDefaults standardUserDefaults]objectForKey:@"memberInfor"];
        _imageURL=[dics objectForKey:@"headPortrait"];
       
        [self.myHeadPortrait sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:[UIImage imageNamed:@"nzg_touxiang_03"]];
        
        NSLog(@"result===%@",result);
        NSLog(@"jsonDict===%@",jsonDict);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    

    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
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
