//
//  AppDelegate.m
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import "AppDelegate.h"



#import <MediaPlayer/MediaPlayer.h>
#import "CCLivingViewController.h"//直播
#import "CCColumnViewController.h"//栏目
#import "CCMineViewController.h"//我的
#import "CCSetupViewController.h"//设置
#import "CCHomeTabbarItem.h"
#import "LeftSlideViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "CCLeftViewController.h"
#import "IQKeyboardManager.h"
#import "GuideController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <Bugly/Bugly.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
static BOOL isProduction = TRUE;

@interface AppDelegate ()
{
     NSInteger _login;
    MMDrawerController *_drawController;
    BOOL _isFullScreen;
    NSString *_str1;
    NSString *_str2;
    BOOL flag;
}

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *win = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    win.backgroundColor = [UIColor whiteColor];
    [Bugly startWithAppId:@"900058333"];
//    请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"4SGE1kLSh9GteAVaNITnER38xdGwX06N"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    self.window = win;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"APP_VERSION"];
    if (oldVersion && [oldVersion isEqualToString:nowVersion]) {
        [self setUpAppHomeController];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nowVersion forKey:@"APP_VERSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        GuideController *guideVC = [GuideController new];
        self.window.rootViewController = guideVC;
    }
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;//这个是点击空白区域键盘收缩的开关
    manager.enableAutoToolbar =NO;//这个是它自带键盘工具条开关

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterFullScreen:)name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willExitFullScreen:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    
    
    [win makeKeyAndVisible];
    [ShareSDK registerApp:@"18a475e4cd24a"
     
          activePlatforms:@[
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeQQ)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
            
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx9ce22e1487fb0dec"
                                       appSecret:@"307d08276a4c008410491f707dfac341"];
                 break;
                 
                 
                 
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105716091"
                                      appKey:@"uDsY1kmHM5L6XKHy"
                                    authType:SSDKAuthTypeBoth];
                 break;
             
             default:
                 break;
         }
     }];
    
    NSDictionary *dic2=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginDic"];
    _str1=[dic2 objectForKey:@"successful"];
    _str2=[dic2 objectForKey:@"account"];
    _login=_str1.integerValue;
#pragma mark - //JPuah
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    
    [JPUSHService setupWithOption:launchOptions appKey:@"2407221b885b03280c605a50"
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    //JPush 监听登陆成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];
   
    return YES;
}


/**
 *  登录成功，设置别名，移除监听
 *
 *  @param notification <#notification description#>
 */
- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
    
   
    if (_login==1) {
        
        NSLog(@"str2==%@",_str2);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            [JPUSHService setTags:nil alias:_str2
            fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                NSLog(@"%d----%@---",iResCode,iAlias);
                
            }];
        });
   
        
    }else if (_login==0){
        NSString *strTags = [NSString stringWithCString:"unregistered" encoding:NSUTF8StringEncoding];
        NSSet *tagSet = [[NSSet alloc] initWithObjects:strTags ,nil];
        [JPUSHService setTags:tagSet callbackSelector:nil object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kJPFNetworkDidLoginNotification
                                                  object:nil];
}  



- (void)applicationDidEnterBackground:(UIApplication *)application {
    flag=NO;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken＝＝＝%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    
}




- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"8.0收到通知：%@",userInfo);
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    if (flag==NO) {
        
        
        
        NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize ",content,(long)badge,sound);
        [JPUSHService handleRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }else if (flag==YES){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"通知" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
   
    
}

- (void)willEnterFullScreen:(NSNotification *)notification
{
    _isFullScreen = YES;
}

- (void)willExitFullScreen:(NSNotification *)notification
{
    _isFullScreen = NO;
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (_isFullScreen) {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }

}


- (void)setUpAppHomeController {
    [self setUpHomeController];
    
}
- (void)setUpHomeController {
    if ( self.homeVC )
    {
        self.window.rootViewController = self.homeVC;
        return;
    }
    
    NSMutableArray *items = [NSMutableArray array];
    //首页
    CCHomepageController *homepageVC = [[CCHomepageController alloc]init];
    
    self.mainVC = homepageVC;

    CCNavgationController *homepageNav = [CCNavgationController navigationWithWrapController:homepageVC];
       self.navgationVC = homepageNav;
    CCHomeTabbarItem *homepageItem = [CCHomeTabbarItem homeTabBarItemWithController:homepageNav];
        [items addObject:homepageItem];
    
    //直播
    CCLivingViewController *livingVC = [[CCLivingViewController alloc]init];
    CCNavgationController *livingNav = [CCNavgationController navigationWithWrapController:livingVC];
    CCHomeTabbarItem *livingItem = [CCHomeTabbarItem homeTabBarItemWithController:livingNav];
    [items addObject:livingItem];
    
    //栏目
    CCColumnViewController *columnVC = [[CCColumnViewController alloc]init];
    CCNavgationController *columnNav = [CCNavgationController navigationWithWrapController:columnVC];
    CCHomeTabbarItem *columnItem = [CCHomeTabbarItem homeTabBarItemWithController:columnNav];
    [items addObject:columnItem];
    
    //我的
    CCMineViewController *mineVC = [[CCMineViewController alloc]init];
    CCNavgationController *mineNav = [CCNavgationController navigationWithWrapController:mineVC];
    CCHomeTabbarItem *mineItem = [CCHomeTabbarItem homeTabBarItemWithController:mineNav];
    [items addObject:mineItem];
    
    //设置
    CCSetupViewController *setupVC = [[CCSetupViewController alloc]init];
    CCNavgationController *setupNav = [CCNavgationController navigationWithWrapController:setupVC];
    CCHomeTabbarItem *setupItem = [CCHomeTabbarItem homeTabBarItemWithController:setupNav];
    [items addObject:setupItem];
    
    
    
    
    CCHomeTabbarController *homeTabbarVC = [CCHomeTabbarController homeViewControllerWithItems:items];
    
    
    CCLeftViewController *left=[[CCLeftViewController alloc]init];
    
    left.nav=self.navgationVC;
    _drawController=[[MMDrawerController alloc]initWithCenterViewController:homeTabbarVC leftDrawerViewController:left];
    
    _drawController.maximumLeftDrawerWidth=300.0/360.0*ScreenWidth;
    homeTabbarVC.selectedIndex = 0;
    self.window.rootViewController = _drawController;
    
    
    
}

/*
- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    if (!_drawerAnimator) {
        _drawerAnimator = [[JVFloatingDrawerSpringAnimator alloc] init];
    }

   return _drawerAnimator;
}


+ (AppDelegate *)globalDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (void)toggleLeftDrawer:(id)sender animated:(BOOL)animated {
    [_drawer toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:nil];
}

 */
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    flag=YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
