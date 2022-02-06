//
//  NewsLoader.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "NewsLoader.h"
#import "NewsParserProtocol.h"
#import "NewsXMLParser.h"

@interface NewsLoader ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) id<NewsParserProtocol> parser;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSArray<NSOperation *> *> *operations;

@end

@implementation NewsLoader

- (instancetype)initWithParser:(id<NewsParserProtocol>)parser {
    self = [super init];
    if (self) {
        _parser = parser;
        _queue = [NSOperationQueue new];
        _operations = [NSMutableDictionary new];
    }
    
    return self;
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    
    return _session;
}

- (void)loadNews:(void (^)(NSArray<NewsItemModel *> *, NSError *))completion {
    NSURL *url = [NSURL URLWithString:@"https://www.jpl.nasa.gov/feeds/news"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData *data,
                                                                         NSURLResponse *response,
                                                                         NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        [self.parser parseNews:data completion:completion];
    }];
    
    [dataTask resume];
}

@end
