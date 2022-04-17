//
//  NewsViewModel.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 13.03.2022.
//

#import "NewsViewModelProtocol.h"
#import "NewsFetcher.h"

@interface NewsViewModel : NSObject <NewsViewModelProtocol>

# pragma mark - Public properties
@property (nonatomic, strong) id<NewsFetcherProtocol> fetcher;
@property (nonatomic, weak) NSThread *thread;

@end
