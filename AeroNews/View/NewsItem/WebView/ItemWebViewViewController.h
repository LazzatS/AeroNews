//
//  ItemWebViewViewController.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 04.04.2022.
//

#import <UIKit/UIKit.h>
#import "WebKit/WebKit.h"
#import "Constants.h"

@interface ItemWebViewViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) NSURL *url;

@end

