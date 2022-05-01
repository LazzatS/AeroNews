//
//  NewsItemDescriptionViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 18.04.2022.
//

#import "ItemDescriptionViewController.h"

@interface ItemDescriptionViewController ()

@property (nonatomic, strong) ItemModel *item;

@end

@implementation ItemDescriptionViewController

- (instancetype)initWithNewsItem: (ItemModel *)newsItem {
    
    self = [super init];
    
    if (self) {
        self.item = newsItem;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTitleLabel:self.item.title];
}

- (void)createTitleLabel:(NSString *)title {
    UILabel *titleLabel = [[[UILabel alloc] init] autorelease];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor labelColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    
    [self setupTitleLayout:titleLabel];
}

- (void)setupTitleLayout:(UILabel *)titleLabel {
    [self.view addSubview:titleLabel];
    
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor
                                             constant:10].active = YES;
    [titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor
                                              constant:-10].active = YES;
    [titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor
                                         constant:navBarHeight].active = YES;
    [titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

@end
