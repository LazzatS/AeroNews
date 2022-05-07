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

- (void)fetchNewsFromURL:(NSURL *)url
             withSuccess:(void (^)(NSArray<ItemModel *> *))successCompletion
               withError:(void (^)(NSError *))errorCompletion {
    
    __weak NetworkLayer *weakSelf = self;
    
    NSThread *thread = [[[NSThread alloc] initWithBlock:^{
        
        [weakSelf.newsLoader loadNews:^(NSData *data, NSError *loadError) {
            if (data == nil) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    errorCompletion(loadError);
                    
                });
                
            }
            
            [weakSelf.newsParser parseNews:data
                                completion:^(NSArray<ItemModel *> *news,
                                             NSError *parseError) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (parseError == nil) {
                        successCompletion(news);
                    } else {
                        errorCompletion(nil);
                    }
                    
                });
                
            }];
            
        }];
    }] autorelease];
    
    [thread start];
}
@end
