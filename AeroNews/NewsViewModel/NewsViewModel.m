//
//  NewsViewModel.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 13.03.2022.
//

#import "NewsViewModel.h"

@interface NewsViewModel ()

@property (nonatomic, strong) NSArray<NewsItemModel *> *news;

@end

@implementation NewsViewModel

#pragma mark - Custom initilizer
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        self.news = @[];
        self.fetcher = [[[NewsFetcher alloc]
                         initWithLoader:[[NewsLoader alloc] init]
                         andParser:[[NewsXMLParser alloc] init]]
                        autorelease];
    }
    
    return self;
}

#pragma mark - Get news method
- (void)getNewsWithSuccess: (void (^)(NSArray<NewsItemModel *> *))successCompletion
                     error: (void (^)(NSError *))errorCompletion
                   fromURL: (NSURL *)url {
    
    __weak NewsViewModel *weakSelf = self;
    
    self.thread = [[[NSThread alloc] initWithBlock:^{
        [weakSelf.fetcher fetchNews:^(NSArray<NewsItemModel *> *news, NSError *error) {
            
            if (news == nil) {
                errorCompletion(error);
            }
            
            NSMutableArray *newsItems = [[[NSMutableArray alloc] init] autorelease];
            
            for (NewsItemModel *newsItem in news) {
                [newsItems addObject:newsItem];
            }
            
            [weakSelf setNews:newsItems];
            successCompletion(newsItems);
            
        } fromURL:url];
    }] autorelease];
    
    [self.thread start];
}

#pragma mark - Get number of items
- (NSUInteger)numberOfNewsItems {
    return self.news.count;
}

#pragma mark - Get item at indexPath
- (NewsItemModel *)newsItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.news.count) {
        return nil;
    }
    
    return self.news[indexPath.row];
}

@end
