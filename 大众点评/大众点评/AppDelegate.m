//
//  AppDelegate.m
//  大众点评
//
//  Created by qianfeng on 3/28/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "AppDelegate.h"
#import "DPAPI.h"

#import "TabBarCon.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)dealloc
{
    self.window = nil;
    [super dealloc];
}

+ (AppDelegate *)instance {
    return [[UIApplication sharedApplication] delegate];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dpapi = [[DPAPI alloc] init];
        _appKey = [[NSUserDefaults standardUserDefaults] valueForKey:@"appkey"];
        if (_appKey.length < 1) {
            _appKey = kDPAppKey;
        }
        _appSecret = [[NSUserDefaults standardUserDefaults] valueForKey:@"appsecret"];
        if (_appSecret.length < 1) {
            _appSecret = kDPAppSecret;
        }
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    TabBarCon *tabBarC = [[TabBarCon alloc] init];
    [self.window setRootViewController:tabBarC];
    [tabBarC release];
    
    return YES;
}

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
