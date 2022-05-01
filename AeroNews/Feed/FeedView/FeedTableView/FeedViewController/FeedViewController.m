//
//  FeedViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "FeedViewController.h"
#import "ItemViewModelProtocol.h"
#import "ItemViewModel.h"

@interface FeedViewController ()

#pragma mark - Dependencies
@property (nonatomic, strong) id<ViewModelProtocol> viewModel;
@property (nonatomic, strong) ItemWebViewViewController *itemWebViewVC;

#pragma mark - UI elements
@property (nonatomic, weak) UITableView *newsTableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation FeedViewController

- (instancetype)initWithViewModel: (id<ViewModelProtocol>)viewModel {
    
    self = [super init];
    
    if (self) {
        self.viewModel = viewModel;
    }
    
    return self;
}

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
    
    [self getData];
}

- (void)getData {
    [self.activityIndicator startAnimating];
    
    __weak FeedViewController *weakSelf = self;
    
    [self.viewModel getNewsFromURL:[NSURL URLWithString:urlString]
                           success:^(NSArray<ItemModel *> *news) {
        
        [weakSelf.activityIndicator stopAnimating];
        [weakSelf.newsTableView reloadData];
        
    }
                             error:^(NSError *error) {
        
        [weakSelf.activityIndicator stopAnimating];
        [weakSelf showAlert:@"Error"
                    message:[error localizedDescription]
                         on:self];
        
    }];
}


#pragma mark - private UI methods
- (void)createNewsTableView {
    self.newsTableView = [[[UITableView alloc]
                           initWithFrame:CGRectMake(0, 0,
                                                    self.view.frame.size.width,
                                                    self.view.frame.size.height)
                           style:UITableViewStylePlain] autorelease];
    
    [self.newsTableView registerClass:FeedTableViewCell.self
               forCellReuseIdentifier: [FeedTableViewCell reuseIdentifier]];
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

- (void)showAlert:(NSString *)title message:(NSString *)message on:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [vc presentViewController:alert animated:YES completion:nil];
}


#pragma mark - table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemViewModel *itemViewModel = [ItemViewModel newAllocInit:[self.viewModel newsItemAtIndexPath:indexPath]];
    self.itemWebViewVC = [[ItemWebViewViewController alloc] initWithViewModel:itemViewModel];
    [self.navigationController pushViewController:self.itemWebViewVC animated:YES];
}


#pragma mark - table view data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfNewsItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FeedTableViewCell reuseIdentifier]
                                                              forIndexPath:indexPath];
    ItemModel *newsItem = [self.viewModel newsItemAtIndexPath:indexPath];
    [cell configure:newsItem];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
