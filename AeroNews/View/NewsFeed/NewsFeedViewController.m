//
//  NewsFeedViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "NewsFeedViewController.h"
#import "TableViewCell.h"

#import "NewsItemModel.h"
#import "NewsViewModel.h"

#import "NewsItemDetailsViewController.h"

static NSString *reuseIdentifier = @"TableViewCell";

@interface NewsFeedViewController () <UITableViewDelegate, UITableViewDataSource>

#pragma mark - Dependencies
@property (nonatomic, weak) NSThread *thread;

#pragma mark - News items
@property (nonatomic, copy) NSArray<NewsItemModel *> *dataSource;

#pragma mark - UI elements
@property (nonatomic, weak) UITableView *newsTableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Aeronews";
    [self createNewsTableView];
    [self createActivityIndicator];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startLoading];
}

#pragma mark - private UI methods
- (void)createNewsTableView {
    self.newsTableView = [[[UITableView alloc]
                           initWithFrame:CGRectMake(0, 0,
                                                    self.view.frame.size.width,
                                                    self.view.frame.size.height)
                           style:UITableViewStylePlain] autorelease];
    
    [self.newsTableView registerClass:TableViewCell.self
               forCellReuseIdentifier: @"TableViewCell"];
    self.newsTableView.dataSource = self;
    self.newsTableView.delegate = self;
    
    [self.view addSubview:self.newsTableView];
}

- (void)createActivityIndicator {
    self.activityIndicator = [[[UIActivityIndicatorView alloc]
                               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge]
                              autorelease];
    [self.newsTableView addSubview:self.activityIndicator];
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.hidesWhenStopped = YES;
}

#pragma mark - load method
- (void)startLoading {
    [self.activityIndicator startAnimating];
    
    NewsViewModel *viewModel = [[NewsViewModel new] autorelease];
    
    __weak typeof(self) weakSelf = self;
    
    // run loading on a separate thread
    self.thread = [[NSThread alloc] initWithBlock:^{
        
        [viewModel fetchNews:^(NSArray<NewsItemModel *> *news, NSError *error) {
            weakSelf.dataSource = news;
            
            // reload table view on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    
                    [weakSelf.activityIndicator stopAnimating];
                    [viewModel showAlert:@"Error"
                                 message:[error localizedDescription]
                                      on:self];
                } else {
                    
                    [weakSelf.newsTableView reloadData];
                    [weakSelf.activityIndicator stopAnimating];
                }
            });
        }];
    }];
    
    [self.thread start];
}


#pragma mark - table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = [NSURL URLWithString:self.dataSource[indexPath.row].link];
    NewsItemDetailsViewController *newsItemVC = [[NewsItemDetailsViewController new] autorelease];
    newsItemVC.url = url;
    [self.navigationController pushViewController:newsItemVC animated:YES];
}


#pragma mark - table view data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                          forIndexPath:indexPath];
    NewsItemModel *newsItem = self.dataSource[indexPath.row];
    [cell configure:newsItem];
    
    return cell;
}

@end
