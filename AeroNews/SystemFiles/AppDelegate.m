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
    
    NewsFeedViewController *newsFeedVC = [[NewsFeedViewController new] autorelease];
    
    UINavigationController *nav = [[[UINavigationController alloc]
                                    initWithRootViewController:newsFeedVC]
                                   autorelease];
    nav.navigationBar.backgroundColor = [UIColor systemBackgroundColor];
    
    self.window.backgroundColor = [UIColor systemBackgroundColor];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
