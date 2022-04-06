//
//  TableViewCell.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 05.02.2022.
//

#import "TableViewCell.h"
#import "NewsItemModel.h"

static CGFloat cellHeight = 100;

@interface TableViewCell ()

@property (nonatomic, strong) UIView *customContentView;

@end

@implementation TableViewCell

- (void)configure:(NewsItemModel *)item {
    [self createCustomContentView];
    [self createTitleLabel:item.title];
}

#pragma mark - Private methods

- (void)createCustomContentView {
    self.customContentView = [[[UIView alloc] init] autorelease];
    
    self.customContentView.layer.cornerRadius = 20;
    self.customContentView.layer.borderWidth = 3;
    self.customContentView.layer.borderColor = [[UIColor systemBlueColor] CGColor];
    self.customContentView.backgroundColor = [UIColor systemBackgroundColor];
    
    [self.contentView addSubview:_customContentView];
    
    [self.customContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.customContentView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor
                                                         constant:15].active = YES;
    [self.customContentView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor
                                                          constant:-15].active = YES;
    [self.customContentView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.customContentView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [self.customContentView.heightAnchor constraintGreaterThanOrEqualToConstant:cellHeight].active = YES;
}

#pragma mark - Title Label

- (void)createTitleLabel:(NSString *)title {
    UILabel *titleLabel = [[[UILabel alloc] init] autorelease];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor labelColor];
    titleLabel.font = [UIFont systemFontOfSize:22];
    
    [self setupTitleLayout:titleLabel];
}

- (void)setupTitleLayout:(UILabel *)titleLabel {
    [self.customContentView addSubview:titleLabel];
    
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLabel.leadingAnchor constraintEqualToAnchor:self.customContentView.leadingAnchor
                                             constant:10].active = YES;
    [titleLabel.trailingAnchor constraintEqualToAnchor:self.customContentView.trailingAnchor
                                              constant:-10].active = YES;
    [titleLabel.topAnchor constraintEqualToAnchor:self.customContentView.topAnchor
                                         constant:10].active = YES;
    [titleLabel.centerYAnchor constraintEqualToAnchor:self.customContentView.centerYAnchor].active = YES;
}

@end
