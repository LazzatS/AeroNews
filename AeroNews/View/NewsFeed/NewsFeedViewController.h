//
//  NewsFeedViewController.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "TableViewCell.h"
#import "NewsItemModel.h"
#import "NewsViewModel.h"
#import "NewsViewModelProtocol.h"
#import "NewsItemDetailsViewController.h"

@interface NewsFeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@end

#pragma mark - Table View Cell identifier
static NSString *reuseIdentifier = @"TableViewCell";
