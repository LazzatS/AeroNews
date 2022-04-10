//
//  NewsItemDetailsViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 04.04.2022.
//

#import "NewsItemDetailsViewController.h"

CGFloat navBarHeight = 64;
CGFloat toolBarHeight = 64;
CGFloat progressViewHeight = 10;

@interface NewsItemDetailsViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *stopBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *safariBarButtonItem;

@end

@implementation NewsItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.backgroundColor = [UIColor systemBackgroundColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // layout views
    
    [self setupWebView];
    [self setupToolbar];
    [self setupProgressBar];
    
    // set observers
    
    [self.webView addObserver:self
                   forKeyPath:@"canGoBack"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    
    [self.webView addObserver:self
                   forKeyPath:@"canGoForward"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
}

#pragma mark - Web View Observers

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"canGoBack"] || [keyPath isEqualToString:@"canGoForward"]) {
        self.backBarButtonItem.enabled = self.webView.canGoBack;
        self.forwardBarButtonItem.enabled = self.webView.canGoForward;
    }
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setHidden:NO];
        self.progressView.progress = self.webView.estimatedProgress;
        
        if (self.webView.estimatedProgress >= 0.99) {
            [self.progressView setHidden:YES];
        }
    }
    
}

#pragma mark - Web View

- (void)setupWebView {
    
    // web view configuration
    self.webView = [[[WKWebView alloc] init] autorelease];
    [self.webView setAllowsBackForwardNavigationGestures:YES];
    
    [self.webView setUIDelegate:self];
    [self.webView setNavigationDelegate:self];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];

    [self.view addSubview:self.webView];
    
    // web view layout
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor
                                           constant:navBarHeight + progressViewHeight].active = YES;
    [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor
                                              constant:-toolBarHeight].active = YES;
}

#pragma mark - ToolBar

- (void)setupToolbar {
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.backgroundColor = [UIColor systemBackgroundColor];
    [self setToolbarItems:[self toolbarButtons]];
    
    [self.backBarButtonItem setEnabled:NO];
    [self.forwardBarButtonItem setEnabled:NO];
}

- (NSArray <UIBarButtonItem *> *)toolbarButtons {
    
    UIBarButtonItem *spaceItem = [self spaceItem];
    
    [self setupBackButton];
    [self setupForwardButton];
    [self setupRefreshButton];
    [self setupStopButton];
    [self setupSafariButton];
    
    return @[(id)self.backBarButtonItem, spaceItem,
             (id)self.forwardBarButtonItem, spaceItem,
             (id)self.refreshBarButtonItem, spaceItem,
             (id)self.stopBarButtonItem, spaceItem,
             (id)self.safariBarButtonItem];
}

#pragma mark - Progress View

- (void)setupProgressBar {
    self.progressView = [[[UIProgressView alloc]
                          initWithProgressViewStyle:UIProgressViewStyleDefault]
                         autorelease];
    self.progressView.progressTintColor = [UIColor redColor];

    [self.view addSubview:self.progressView];
    
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.progressView.topAnchor constraintEqualToAnchor:self.webView.topAnchor
                                                constant:progressViewHeight].active = YES;
    [self.progressView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.progressView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.progressView.heightAnchor constraintEqualToConstant:progressViewHeight].active = YES;
}

- (void)setupBackButton {
    self.backBarButtonItem = [[[UIBarButtonItem alloc]
                               initWithImage:[UIImage systemImageNamed:@"chevron.left"]
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(backBarButtonTapped)]
                              autorelease];
}

- (void)setupForwardButton {
    self.forwardBarButtonItem = [[[UIBarButtonItem alloc]
                                  initWithImage:[UIImage systemImageNamed:@"chevron.right"]
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(forwardBarButtonTapped)]
                                 autorelease];
}

- (void)setupRefreshButton {
    self.refreshBarButtonItem = [[[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                  target:self
                                  action:@selector(reloadBarButtonTapped)]
                                 autorelease];
}

- (void)setupStopButton {
    self.stopBarButtonItem = [[[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                               target:self
                               action:@selector(stopBarButtonTapped)]
                              autorelease];
}

- (void)setupSafariButton {
    self.safariBarButtonItem = [[[UIBarButtonItem alloc]
                                 initWithImage:[UIImage systemImageNamed:@"safari"]
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(safariBarButtonTapped)]
                                autorelease];
}

- (UIBarButtonItem *)spaceItem {
    UIBarButtonItem *spaceItem = [[[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                   target:self
                                   action:nil]
                                  autorelease];
    return spaceItem;
}

- (void)backBarButtonTapped {
    [self.webView goBack];
}

- (void)forwardBarButtonTapped {
    [self.webView goForward];
}

- (void)reloadBarButtonTapped {
    [self.webView reload];
}

- (void)stopBarButtonTapped {
    [self.webView stopLoading];
}

- (void)safariBarButtonTapped {
    NSURL *currentURL = [[self.webView URL] absoluteURL];
    [[UIApplication sharedApplication] openURL:currentURL
                                       options:@{}
                             completionHandler:nil];
}

@end
