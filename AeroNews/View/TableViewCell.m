//
//  TableViewCell.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 05.02.2022.
//

#import "TableViewCell.h"
#import "NewsItemModel.h"

static CGFloat cellHeight = 100;

@implementation TableViewCell

- (void)configure:(NewsItemModel *)item {
    [self createCustomContentView];
    [self createTitleLabel:item.title];
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

#pragma mark - Title Label

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
    [titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
}

@end
