//
//  JSAppDelegate.m
//  DoubanMini
//
//  Created by json on 14/9/28.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSAppDelegate.h"
#import "MainController.h"
#import "JSfmViewController.h"
#import "Sqlite3Manager.h"
#import <AVFoundation/AVFoundation.h>
@implementation JSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //判断设备屏幕大小以及ios版本
    NSString *key=(NSString *)kCFBundleVersionKey;
    NSString *version= [NSBundle mainBundle].infoDictionary[key];
    //从沙盒中取出上次存储的版本号
    NSString *saveVersion= [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //判断版本号是否相同
    if ([version isEqualToString:saveVersion]) {
        //版本号相同
        self.window.RootViewController=[[MainController alloc]init] ;
        //显示状态栏，应用程序一般都要显示状态栏（常识）
#pragma mark---//当前代码行可以与上一行顺序交换
        application.statusBarHidden =NO;
        
    }else{
        //第一次使用新版本
        //将新版本写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        //将版本号马上写入沙盒
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.window.rootViewController=[[MainController alloc]init];
        
    }
    //创建数据库
    [self CreateDataBase];
    //使程序能后台播放音乐
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible]; 
    return YES;

}
//创建数据库
-(void)CreateDataBase
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path=[path stringByAppendingPathComponent:@"DoubanMini.sqlite3"];
    [ [[Sqlite3Manager alloc]init] OpenDataBaseWithPath:path];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
