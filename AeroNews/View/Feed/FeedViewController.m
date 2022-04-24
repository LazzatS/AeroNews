//
//  FeedViewController.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "FeedViewController.h"

@interface FeedViewController ()

#pragma mark - Dependencies
@property (nonatomic, strong) id<ViewModelProtocol> viewModel;

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
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf.newsTableView reloadData];
        });
        
    }
                             error:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showAlert:@"Error"
                        message:[error localizedDescription]
                             on:self];
        });
        
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
               forCellReuseIdentifier: @"FeedTableViewCell"];
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
    ItemWebViewViewController *newsItemVC = [[ItemWebViewViewController new] autorelease];
    NSURL *url = [NSURL URLWithString:[self.viewModel newsItemAtIndexPath:indexPath].link];
    newsItemVC.url = url;
    [self.navigationController pushViewController:newsItemVC animated:YES];
}


#pragma mark - table view data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfNewsItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                              forIndexPath:indexPath];
    ItemModel *newsItem = [self.viewModel newsItemAtIndexPath:indexPath];
    [cell configure:newsItem];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)dealloc {
    NSLog(@"dealloc");
    self.viewModel = nil;
    [super dealloc];
}

@end
