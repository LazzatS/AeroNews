//
//  FeedTableViewCell.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 05.02.2022.
//

#import "FeedTableViewCell.h"

@interface FeedTableViewCell ()

@property (nonatomic, strong) UIView *customContentView;
@property (nonatomic, strong) UIButton *infoButton;

@end

@implementation FeedTableViewCell

- (void)configure:(ItemModel *)item {
    [self createCustomContentView];
    [self createInfoIcon];
    [self createTitleLabel:item.title];
}

#pragma mark - Private methods

- (void)createCustomContentView {
    self.customContentView = [[[UIView alloc] init] autorelease];
    
    self.customContentView.layer.cornerRadius = 10;
    self.customContentView.layer.borderWidth = 1;
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
}

#pragma mark - Info icon

- (void)createInfoIcon {
    self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    self.infoButton.tintColor = [UIColor systemBlueColor];
    
    [self.infoButton addTarget:self
                        action:@selector(didTapInfoButton)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self setupInfoIconLayout:self.infoButton];
}

- (void)setupInfoIconLayout: (UIButton *)infoButton {
    [self.customContentView addSubview:infoButton];
    
    [infoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [infoButton.trailingAnchor constraintEqualToAnchor:self.customContentView.trailingAnchor
                                              constant:-10].active = YES;
    [infoButton.centerYAnchor constraintEqualToAnchor:self.customContentView.centerYAnchor].active = YES;
    [infoButton.widthAnchor constraintEqualToConstant:20].active = YES;
    [infoButton.heightAnchor constraintEqualToConstant:20].active = YES;
}


#pragma mark - Title Label

- (void)createTitleLabel:(NSString *)title {
    UILabel *titleLabel = [[[UILabel alloc] init] autorelease];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor labelColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    [self setupTitleLayout:titleLabel];
}

- (void)setupTitleLayout:(UILabel *)titleLabel {
    [self.customContentView addSubview:titleLabel];
    
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLabel.leadingAnchor constraintEqualToAnchor:self.customContentView.leadingAnchor
                                             constant:10].active = YES;
    [titleLabel.trailingAnchor constraintEqualToAnchor:self.infoButton.leadingAnchor
                                              constant:-10].active = YES;
    [titleLabel.topAnchor constraintEqualToAnchor:self.customContentView.topAnchor
                                         constant:10].active = YES;
    [titleLabel.centerYAnchor constraintEqualToAnchor:self.customContentView.centerYAnchor].active = YES;
}

- (void)didTapInfoButton {
    NSLog(@"tapped info button");
}

@end
