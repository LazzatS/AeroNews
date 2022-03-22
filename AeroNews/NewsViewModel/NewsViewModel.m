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

#pragma mark - URL
static NSString *urlString = @"https://www.jpl.nasa.gov/feeds/news";

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
    
    NSURL *url = [NSURL URLWithString:urlString];
    NewsLoader *loader = [[NewsLoader new] autorelease];
    NewsXMLParser *parser = [[NewsXMLParser new] autorelease];
    
    [self initWithLoader:loader andParser:parser];
    
    [loader loadNews:^(NSData *newsData, NSError *loadError) {
        
        if (newsData == nil) {
            completion(nil, loadError);
        }
        
        [parser parseNews:newsData completion:^(NSArray<NewsItemModel *> *newsItems, NSError *parseError) {
            completion(newsItems, parseError);
        }];
        
    } from:url];
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
