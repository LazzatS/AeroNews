//
//  ViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "ViewController.h"
#import "NewsLoader/NewsLoader.h"
#import "NewsParser/NewsXMLParser.h"
#import "NewsItemModel/NewsItemModel.h"
#import "TableViewCell.h"

static NSString *reuseIdentifier = @"TableViewCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *newsTableView;

@property (nonatomic, strong) NewsLoader *newsLoader;
@property (nonatomic, copy) NSArray<NewsItemModel *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsLoader = [[NewsLoader alloc] initWithParser:[NewsXMLParser new]];
    self.dataSource = [NSArray new];
    
    [self createNewsTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startLoading];
}

- (void)createNewsTableView {
    self.newsTableView = [[UITableView alloc]
                           initWithFrame:CGRectMake(0, 0,
                                                    self.view.frame.size.width,
                                                    self.view.frame.size.height)
                           style:UITableViewStylePlain];
    
    [self.newsTableView registerClass:TableViewCell.self
               forCellReuseIdentifier: @"TableViewCell"];
    self.newsTableView.dataSource = self;
    self.newsTableView.delegate = self;
    
    [self.view addSubview:self.newsTableView];
}

- (void)startLoading {
    __weak typeof(self) weakSelf = self;
    [self.newsLoader loadNews:^(NSArray<NewsItemModel *> *news, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                } else {
                    weakSelf.dataSource = news;
                    [weakSelf.newsTableView reloadData];
                }
            });
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

@end
