//
//  TableViewCell.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 05.02.2022.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"

@class ItemModel;

@interface TableViewCell : UITableViewCell

#pragma mark - Public methods
- (void)configure:(ItemModel *)item;

#pragma mark - Private methods
- (void)createCustomContentView;
- (void)setupTitleLayout:(UILabel *)titleLabel;
- (void)createInfoIcon;
- (void)setupInfoIconLayout: (UIButton *)infoButton;

@end
