//
//  NewsItemDetailsViewController.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 04.04.2022.
//

#import <UIKit/UIKit.h>
#import "WebKit/WebKit.h"

@interface NewsItemDetailsViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) NSURL *url;

@end

