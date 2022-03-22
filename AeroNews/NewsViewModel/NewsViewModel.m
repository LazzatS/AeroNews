//
//  NewsViewModel.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 13.03.2022.
//

#import "NewsViewModel.h"
#import "NewsItemModel.h"
#import "NewsLoader.h"
#import "NewsXMLParser.h"

@implementation NewsViewModel

#pragma mark - Custom initilizer
- (void)initWithLoader: (NewsLoader *)loader andParser: (NewsXMLParser *)parser {
    self = [super init];
    
    if (self) {
        loader = loader;
        parser = parser;
    }
}

#pragma mark - Method to load and parse news
- (void)fetchNews:(void (^)(NSArray<NewsItemModel *> *, NSError *))completion {
    NewsLoader *loader = [[NewsLoader new] autorelease];
    NewsXMLParser *parser = [[NewsXMLParser new] autorelease];

    [self initWithLoader:loader andParser:parser];
    
    [loader loadNews:^(NSData *newsData, NSError *error) {
        [parser parseNews:newsData completion:^(NSArray<NewsItemModel *> *newsItems, NSError *err) {
            completion(newsItems, nil);
        }];
    }];
}

#pragma mark - Private getters and setters
- (NewsLoader *)newsLoader {
    return newsLoader;
}

- (void)setNewsLoader:(NewsLoader *)newNewsLoader {
    [newNewsLoader retain];
    [newsLoader release];
    newsLoader = newNewsLoader;
}

- (NewsXMLParser *)newsXMLParser {
    return newsXMLParser;
}

- (void)setNewsXMLParser:(NewsXMLParser *)newNewsXMLParser {
    [newNewsXMLParser retain];
    [newsXMLParser release];
    newsXMLParser = newNewsXMLParser;
}

@end
