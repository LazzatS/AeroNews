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

- (void)createCustomContentView;

- (void)configure:(NewsItemModel *)item;
- (void)setupTitleLayout:(UILabel *)titleLabel;
- (void)createDateLabel:(NSString *)date;
- (void)setupDateLayout:(UILabel *)dateLabel;

@end

NS_ASSUME_NONNULL_END
