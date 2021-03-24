//
//  AppDelegate.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/1/16.
//

#import "AppDelegate.h"
#import "TestViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    TestViewController *testCtr = [[TestViewController alloc]init];
    self.window.rootViewController = testCtr;
    [self.window makeKeyWindow];
    
    return YES;
}



@end
