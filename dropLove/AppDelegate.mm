//
//  AppDelegate.m
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "AppDelegate.h"
#import "dropHeader.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件


@interface AppDelegate ()<RCIMUserInfoDataSource>
@property (strong, nonatomic) BMKMapManager *mapManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     *  改变导航栏字体颜色（白色）
     */
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if ([[userDef objectForKey:@"user"] isEqualToString:@"YES"]) {
        
    }else{
        NSString *isLogin = @"NO";
        [userDef setObject:isLogin forKey:@"user"];
    }
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //
    HomeViewController *home     = [[HomeViewController alloc]init];
    TimeAxisViewController *time = [[TimeAxisViewController alloc]init];
    SocialViewController *social = [[SocialViewController alloc]init];
    MineViewController *mine     = [[MineViewController alloc]init];
    //
//    home.tabBarItem.title = @"首页";
    
    UINavigationController *timeNvc = [[UINavigationController alloc]initWithRootViewController:time];
    time.tabBarItem.title = @"时光轴";
    timeNvc.navigationBar.translucent = NO;
    timeNvc.navigationBar.backgroundColor = COLOR_MINE;
    time.tabBarItem.image = [[UIImage imageNamed:@"timeAxis@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    time.tabBarItem.selectedImage = [[UIImage imageNamed:@"timeAxisHight@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *socialNvc = [[UINavigationController alloc]initWithRootViewController:social];
    social.tabBarItem.title = @"社区";
    socialNvc.navigationBar.translucent = NO;
    socialNvc.navigationBar.backgroundColor = COLOR_MINE;
    social.tabBarItem.image = [[UIImage imageNamed:@"social@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    social.tabBarItem.selectedImage = [[UIImage imageNamed:@"socialHight@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    mine.tabBarItem.title = @"我的";
    
    mine.tabBarItem.image = [[UIImage imageNamed:@"mine1@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    mine.tabBarItem.selectedImage = [[UIImage imageNamed:@"mineHight1@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:home];
      nvc.navigationBar.translucent = NO;
    nvc.tabBarItem.title = @"首页";
    nvc.tabBarItem.image = [[UIImage imageNamed:@"home@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"homeHight@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nvc.navigationBar.barTintColor = COLOR_MINE;
    
    
    UINavigationController *minevc = [[UINavigationController alloc]initWithRootViewController:mine];
    minevc.navigationBar.translucent = NO;
    minevc.tabBarItem.title = @"我的";
    minevc.navigationBar.barTintColor = COLOR_MINE;

    //
    self.tabBar = [[UITabBarController alloc]init];
    //
    self.tabBar.viewControllers = @[nvc,timeNvc,socialNvc,minevc];
    //设置底部图标和title颜色
    self.tabBar.tabBar.tintColor = COLOR_MINE;
    
    self.window.rootViewController = _tabBar;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] isEqualToString:@"YES"]) {
        self.window.rootViewController = _tabBar;
        
    }else{
        loginViewController *loginVc = [[loginViewController alloc]init];
        self.window.rootViewController = loginVc;
    }
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    
    
    //    初始化融云sdk
    [[RCIM sharedRCIM] initWithAppKey:RONGYUN_KEY];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    //    链接融云服务器
    [[RCIM sharedRCIM] connectWithToken:TOKEN success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld",(long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    

    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"6PK19NT1x999KtdsBRbO5CmITFVZi5gc"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }


    //分享
     [UMSocialData setAppKey:SHARE_SDK];
//    //微信
//      [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
//    //微博
//     [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    //QQ
//    
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];

    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //微信第三方登录
    
        [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    //QQ第三方
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    //微博第三方
  
    return YES;
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    if ([@"7788" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"7788";
        user.name = @"韩梅梅";
        user.portraitUri = @"http://img0.pconline.com.cn/pconline/1508/13/6824500_006_thumb.jpg";
        return completion(user);
    }else if ([@"7777" isEqual:userId]){
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"7777";
        user.name = @"1212";
        user.portraitUri = @"http://e.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=972b6623ccfc1e17fdea84357fa0da35/94cad1c8a786c917abbc830cca3d70cf3bc7574c.jpg";
        return completion(user);

    }
    
    return completion(nil);
}

//分享系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url { return [UMSocialSnsService handleOpenURL:url]; }


//
//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
//    if ([@"9069" isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"9069";
//        user.name = @"韩梅梅";
//        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png”;
//        return completion(user);
//    }
//    return completion(nil);
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
