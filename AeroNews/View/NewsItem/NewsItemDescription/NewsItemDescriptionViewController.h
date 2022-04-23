//
//  NewsItemDescriptionViewController.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 18.04.2022.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
#import "Constants.h"

@interface NewsItemDescriptionViewController : UIViewController

- (instancetype)initWithNewsItem: (ItemModel *)newsItem;

@end
