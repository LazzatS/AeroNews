//
//  NewsItemDescriptionViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 18.04.2022.
//

#import "ItemDescriptionViewController.h"

@interface ItemDescriptionViewController ()

#pragma mark - Dependencies
@property (nonatomic, strong) id<ItemViewModelProtocol> viewModel;

#pragma mark - UI elements
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *readMoreButton;

@end

@implementation ItemDescriptionViewController

- (instancetype)initWithViewModel:(id<ItemViewModelProtocol>)viewModel {
    
    self = [super init];
    
    if (self) {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    [self setupUI];
    
    
}

- (void)setupUI {
    
    __weak ItemDescriptionViewController *weakSelf = self;
    
    [self.viewModel getNewsItemDetails:^(NSString *title,
                                         NSString *description,
                                         NSString *date) {
        [weakSelf createTitleLabel:title];
        [weakSelf createDateLabel:date];
        [weakSelf createDescription:description];
        [weakSelf createReadMoreButton];
    }];
    
}

#pragma mark - Title Label

- (void)createTitleLabel:(NSString *)title {
    self.titleLabel = [[[UILabel alloc] init] autorelease];
    self.titleLabel.text = title;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor labelColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setupTitleLayout:self.titleLabel];
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

#pragma mark - Date Label

- (void)createDateLabel: (NSString *)date {
    self.dateLabel = [[[UILabel alloc] init] autorelease];
    self.dateLabel.text = [self convertDateToString:date];
    self.dateLabel.numberOfLines = 0;
    self.dateLabel.textColor = [UIColor secondaryLabelColor];
    self.dateLabel.font = [UIFont systemFontOfSize:10];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setupDateLayout:self.dateLabel];
}

- (void)setupDateLayout: (UILabel *)dateLabel {
    [self.view addSubview:dateLabel];
    
    [dateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [dateLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor
                                            constant:10].active = YES;
    [dateLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor
                                             constant:-10].active = YES;
    [dateLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor
                                        constant:20].active = YES;
    [dateLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

#pragma mark - Description Label

- (void)createDescription: (NSString *)descriptionText {
    
    self.descriptionLabel = [[[UILabel alloc] init] autorelease];
    self.descriptionLabel.text = descriptionText;
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.textColor = [UIColor labelColor];
    self.descriptionLabel.font = [UIFont systemFontOfSize:16];
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setupDescriptionLayout:self.descriptionLabel];
}

- (void)setupDescriptionLayout: (UILabel *)descriptionLabel {
    [self.view addSubview:descriptionLabel];
    
    [descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [descriptionLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor
                                                   constant:10].active = YES;
    [descriptionLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor
                                                    constant:-10].active = YES;
    [descriptionLabel.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor
                                               constant:20].active = YES;
    [descriptionLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

#pragma mark - Read More Button

- (void)createReadMoreButton {
    
    self.readMoreButton = [[[UIButton alloc] init] autorelease];
    [self.readMoreButton setTitle:@"Read more" forState:UIControlStateNormal];
    [self.readMoreButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    
    [self.readMoreButton addTarget:self
                            action:@selector(didTapReadMore)
                  forControlEvents:UIControlEventTouchUpInside];
    
    
    [self setupButtonLayout:self.readMoreButton];
}

- (void)setupButtonLayout: (UIButton *)button {
    [self.view addSubview:button];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button.topAnchor constraintEqualToAnchor:self.descriptionLabel.bottomAnchor
                                     constant:20].active = YES;
    [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [button.widthAnchor constraintEqualToConstant:self.view.frame.size.width / 2].active = YES;
    [button.heightAnchor constraintEqualToConstant:50].active = YES;
}

- (void)didTapReadMore {
    NSURL *currentURL = [self.viewModel getCurrentURL];
    [[UIApplication sharedApplication] openURL:currentURL
                                       options:@{}
                             completionHandler:nil];
}

- (NSString *)convertDateToString: (NSString *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"E, d MMM yyyy HH:mm:ss Z";
    
    NSDate *pubDate = [formatter dateFromString:date];
    
    formatter.timeZone = [NSTimeZone localTimeZone];
    formatter.dateFormat = @"dd MMM yyyy HH:mm";
    
    return [formatter stringFromDate:pubDate];
}

@end
