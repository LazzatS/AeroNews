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

+ (id<ViewModelProtocol>)newAlloc {
    return [ViewModel alloc];
}

- (instancetype)initWithNetworkLayer: (id<NetworkLayerProtocol>)networkLayer {
    
    self = [super init];
    
    if (self) {
        self.news = @[];
        self.networkLayer = networkLayer;
    }
    
    return self;
}

#pragma mark - Get news method

- (void)getNewsFromURL:(NSURL *)url
               success:(void (^)(NSArray<ItemModel *> *))successCompletion
                 error:(void (^)(NSError *))errorCompletion {
    
    [self.networkLayer fetchNewsFromURL:url
                            withSuccess:^(NSArray<ItemModel *> *news) {
        
        [self setNews:news];
        successCompletion(news);
        
    } withError:^(NSError *error) {
        
        errorCompletion(error);
        
    }];
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
