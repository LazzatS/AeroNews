//
//  FeedViewController.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "FeedTableViewCell.h"
#import "ItemModel.h"
#import "ViewModel.h"
#import "ViewModelProtocol.h"
#import "ItemWebViewViewController.h"

@interface FeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithViewModel: (id<ViewModelProtocol>)viewModel;

@end
