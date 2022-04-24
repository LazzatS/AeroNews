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
    
    UIViewController *rootVC = [self configureRootViewController];
    UINavigationController *nav = [self setupNavControllerWithRootVC:rootVC];
    
    self.window = [self setupWindowWithRootVC:nav];
    
    return YES;
}

- (UIViewController *)configureRootViewController {
    Loader *loader = [[[Loader alloc] init] autorelease];
    XMLParser *parser = [[[XMLParser alloc] init] autorelease];
    
    NetworkLayer *networkLayer = [[[NetworkLayer alloc]
                                   initWithLoader:loader
                                   andParser:parser] autorelease];
    
    ViewModel *viewModel = [[[ViewModel newAlloc]
                             initWithNetworkLayer:networkLayer] autorelease];
    
    FeedViewController *newsFeedVC = [[FeedViewController alloc]
                                          initWithViewModel:viewModel];
    return newsFeedVC;
}

- (UINavigationController *)setupNavControllerWithRootVC: (UIViewController *)rootVC {
    UINavigationController *nav = [[[UINavigationController alloc]
                                    initWithRootViewController:rootVC]
                                   autorelease];
    nav.navigationBar.backgroundColor = [UIColor systemBackgroundColor];
    return nav;
}

- (UIWindow *)setupWindowWithRootVC: (UIViewController *)rootVC {
    UIWindow *window = [[[UIWindow alloc]
                         initWithFrame:[[UIScreen mainScreen] bounds]]
                        autorelease];
    window.backgroundColor = [UIColor systemBackgroundColor];
    [window setRootViewController:rootVC];
    [window makeKeyAndVisible];
    
    return window;
}

@end
