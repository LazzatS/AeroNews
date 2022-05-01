//
//  ItemWebViewViewController.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 04.04.2022.
//

#import <UIKit/UIKit.h>
#import "WebKit/WebKit.h"
#import "ItemViewModelProtocol.h"
#import "Constants.h"

@interface ItemWebViewViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>

- (instancetype)initWithViewModel: (id<ItemViewModelProtocol>)viewModel;

@end

