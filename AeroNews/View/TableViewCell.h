//
//  TableViewCell.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 05.02.2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NewsItemModel;

@interface TableViewCell : UITableViewCell

#pragma mark - Public methods
- (void)configure:(NewsItemModel *)item;

#pragma mark - Private methods
- (void)createCustomContentView;
- (void)setupTitleLayout:(UILabel *)titleLabel;

@end

NS_ASSUME_NONNULL_END
