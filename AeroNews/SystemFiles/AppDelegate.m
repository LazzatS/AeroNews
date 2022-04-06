//
//  AppDelegate.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[[UIWindow alloc]
                    initWithFrame:[[UIScreen mainScreen] bounds]]
                   autorelease];
    
    NewsFeedViewController *newsListVC = [[NewsFeedViewController new] autorelease];
    
    UINavigationController *nav = [[[UINavigationController alloc]
                                    initWithRootViewController:newsListVC]
                                   autorelease];
    nav.navigationBar.backgroundColor = [UIColor systemBackgroundColor];
    
    self.window.backgroundColor = [UIColor systemBackgroundColor];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
