//
//  NewsItemDetailsViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 04.04.2022.
//

#import "NewsItemDetailsViewController.h"

@interface NewsItemDetailsViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation NewsItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupWebView];
    
}

#pragma mark - Web View

- (void)setupWebView {
    self.webView = [[[WKWebView alloc]
                     initWithFrame:self.view.frame]
                    autorelease];
    
    [self.webView setUIDelegate:self];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];

    [self.view addSubview:self.webView];
    
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height + 20;
    
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor
                                           constant:navBarHeight].active = YES;
    [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

@end
