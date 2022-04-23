//
//  ViewModel.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 13.03.2022.
//

#import "ViewModel.h"

@interface ViewModel ()

@property (nonatomic, strong) NSArray<ItemModel *> *news;

@end

@implementation ViewModel

#pragma mark - Custom initilizer
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        self.news = @[];
        self.fetcher = [[[NetworkLayer alloc]
                         initWithLoader:[[[Loader alloc] init] autorelease]     // no
                         andParser:[[[XMLParser alloc] init] autorelease]]
                        autorelease];
    }
    
    return self;
}

#pragma mark - Get news method
- (void)getNewsWithSuccess: (void (^)(NSArray<ItemModel *> *))successCompletion
                     error: (void (^)(NSError *))errorCompletion
                   fromURL: (NSURL *)url {
    
    __weak ViewModel *weakSelf = self;
    
    self.thread = [[[NSThread alloc] initWithBlock:^{                                           // to loader
        [weakSelf.fetcher fetchNews:^(NSArray<ItemModel *> *news, NSError *error) {
            
            if (news == nil) {
                errorCompletion(error);
            }
            
            NSMutableArray *newsItems = [[[NSMutableArray alloc] init] autorelease];
            
            for (ItemModel *newsItem in news) {
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
- (ItemModel *)newsItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.news.count) {
        return nil;
    }
    
    return self.news[indexPath.row];
}

@end
