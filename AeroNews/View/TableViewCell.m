//
//  TableViewCell.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 05.02.2022.
//

#import "TableViewCell.h"
#import "NewsItemModel.h"

static CGFloat cellHeight = 150;

@interface TableViewCell ()

@end

@implementation TableViewCell

- (void)configure:(NewsItemModel *)item {
    [self createCustomContentView];
    [self createTitleLabel:item.title];
    [self createDateLabel:item.pubDate];
}

#pragma mark - Private methods

- (void)createCustomContentView {
    UIView *customContentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                          self.contentView.frame.size.width,
                                                                          cellHeight)]
                                 autorelease];
    
    customContentView.layer.cornerRadius = 20;
    customContentView.layer.borderWidth = 3;
    customContentView.layer.borderColor = [[UIColor blueColor] CGColor];
    customContentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:customContentView];
    
    [customContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [customContentView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [customContentView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [customContentView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [customContentView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [customContentView.heightAnchor constraintGreaterThanOrEqualToConstant:cellHeight].active = YES;
}

// MARK: - Title label

- (void)createTitleLabel:(NSString *)title {
    UILabel *titleLabel = [[[UILabel alloc]
                            initWithFrame:CGRectMake(0, 0,
                                                     self.contentView.frame.size.width,
                                                     100)]
                           autorelease];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:22];
    
    [self setupTitleLayout:titleLabel];
}

- (void)setupTitleLayout:(UILabel *)titleLabel {
    [self.contentView addSubview:titleLabel];
    
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor
                                             constant:10].active = YES;
    [titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor
                                              constant:-10].active = YES;
    [titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor
                                         constant:10].active = YES;
    [titleLabel.heightAnchor constraintEqualToConstant:titleLabel.frame.size.height].active = YES;
}

// MARK: - Date label

- (void)createDateLabel:(NSString *)date {
    UILabel *dateLabel = [[[UILabel alloc]
                            initWithFrame:CGRectMake(0, 0,
                                                     self.contentView.frame.size.width,
                                                     50)]
                           autorelease];
    dateLabel.text = date;
    dateLabel.numberOfLines = 0;
    dateLabel.textColor = [UIColor blackColor];
    dateLabel.font = [UIFont systemFontOfSize:18];
    
    [self setupDateLayout:dateLabel];
}

- (void)setupDateLayout:(UILabel *)dateLabel {
    [self.contentView addSubview:dateLabel];
    
    [dateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [dateLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor
                                            constant:10].active = YES;
    [dateLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor
                                             constant:-10].active = YES;
    [dateLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor
                                           constant:-10].active = YES;
    [dateLabel.heightAnchor constraintEqualToConstant:dateLabel.frame.size.height].active = YES;
}

@end
