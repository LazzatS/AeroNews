//
//  ViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "ViewController.h"
#import "TableViewCell.h"

#import "NewsItemModel.h"
#import "NewsViewModel.h"

static NSString *reuseIdentifier = @"TableViewCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

#pragma mark - News items
@property (nonatomic, copy) NSArray<NewsItemModel *> *dataSource;

#pragma mark - UI elements
@property (nonatomic, weak) UITableView *newsTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNewsTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startLoading];
}

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

- (void)startLoading {
    __weak typeof(self) weakSelf = self;
    NewsViewModel *viewModel = [[NewsViewModel new] autorelease];
    [viewModel fetchNews:^(NSArray<NewsItemModel *> *news, NSError *error) {
        weakSelf.dataSource = news;
        [weakSelf.newsTableView reloadData];
    }];
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = [NSURL URLWithString:self.dataSource[indexPath.row].link];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

@end
