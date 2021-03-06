//
//  FeedTableViewCell.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 05.02.2022.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"

@interface FeedTableViewCell : UITableViewCell

#pragma mark - Table View Cell identifier
+ (NSString *)reuseIdentifier;

#pragma mark - Public methods
- (void)configure:(ItemModel *)item;

#pragma mark - Info button tap handler
@property (nonatomic, copy) void(^infoButtonTapHandler)(void);

#pragma mark - Private methods
- (void)createCustomContentView;
- (void)setupTitleLayout:(UILabel *)titleLabel;
- (void)createInfoIcon;
- (void)setupInfoIconLayout: (UIButton *)infoButton;

@end
