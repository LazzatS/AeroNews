//
//  NewsFetcher.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 16.04.2022.
//

#import "NewsFetcherProtocol.h"
#import "NewsLoader.h"
#import "NewsXMLParser.h"

@interface NewsFetcher : NSObject <NewsFetcherProtocol>

- (instancetype)initWithLoader: (id<NewsLoaderProtocol>)loader
                     andParser: (id<NewsParserProtocol>)parser;

@end
