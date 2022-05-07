//
//  ItemDescriptionViewController.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 18.04.2022.
//

#import <UIKit/UIKit.h>
#import "ItemViewModelProtocol.h"
#import "ItemWebViewViewController.h"
#import "Constants.h"

@interface ItemDescriptionViewController : UIViewController

- (instancetype)initWithViewModel: (id<ItemViewModelProtocol>)viewModel;

@end
