//
//  NewsFetcher.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 16.04.2022.
//

#import "NewsFetcher.h"

@interface NewsFetcher ()

#pragma mark - Properties
@property (nonatomic, strong) id<NewsLoaderProtocol> newsLoader;
@property (nonatomic, strong) id<NewsParserProtocol> newsParser;

@end

@implementation NewsFetcher

#pragma mark - Custom Initializer
- (instancetype)initWithLoader:(id<NewsLoaderProtocol>)loader
                     andParser:(id<NewsParserProtocol>)parser {
    
    self = [super init];
    
    if (self) {
        self.newsLoader = loader;
        self.newsParser = parser;
    }
    
    return self;
}

#pragma mark - Method to fetch items loaded from url
- (void)fetchNews:(void (^)(NSArray<NewsItemModel *> *, NSError *))completion
          fromURL:(NSURL *)url {
    
    __weak NewsFetcher *weakSelf = self;
    
    [weakSelf.newsLoader loadNews:^(NSData *newsData, NSError *loadError) {
        
        if (newsData == nil) {
            completion(nil, loadError);
        }
        
        [weakSelf.newsParser parseNews:newsData
                            completion:^(NSArray<NewsItemModel *> *newsItems,
                                         NSError *parseError) {
            
            completion(newsItems, parseError);
            
        }];
    } from:url];
}

@end
