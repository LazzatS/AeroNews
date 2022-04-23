//
//  NewsFetcher.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 16.04.2022.
//

#import "NetworkLayer.h"

@interface NetworkLayer ()

#pragma mark - Properties
@property (nonatomic, strong) id<LoaderProtocol> newsLoader;
@property (nonatomic, strong) id<ParserProtocol> newsParser;

@end

@implementation NetworkLayer

#pragma mark - Custom Initializer
- (instancetype)initWithLoader:(id<LoaderProtocol>)loader
                     andParser:(id<ParserProtocol>)parser {
    
    self = [super init];
    
    if (self) {
        self.newsLoader = loader;
        self.newsParser = parser;
    }
    
    return self;
}

#pragma mark - Method to fetch items loaded from url
- (void)fetchNews:(void (^)(NSArray<ItemModel *> *, NSError *))completion
          fromURL:(NSURL *)url {
    
    __weak NetworkLayer *weakSelf = self;
    [weakSelf.newsLoader loadNewsFromURL:url
                              completion:^(NSData *data,
                                           NSError *loadError) {
        
            if (data == nil) {
                completion(nil, loadError);
            } else {
                
                [weakSelf.newsParser parseNews:data
                                    completion:^(NSArray<ItemModel *> *array,
                                                 NSError *parseError) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(array, parseError);
                    });
                    
                }];
                
            }
    }];
    
//    [weakSelf.newsLoader loadNews:^(NSData *newsData, NSError *loadError) {
//
//        if (newsData == nil) {
//            completion(nil, loadError);
//        }
//
//        [weakSelf.newsParser parseNews:newsData
//                            completion:^(NSArray<NewsItemModel *> *newsItems,
//                                         NSError *parseError) {
//
//            completion(newsItems, parseError);
//
//        }];
//    } from:url];
}

@end
