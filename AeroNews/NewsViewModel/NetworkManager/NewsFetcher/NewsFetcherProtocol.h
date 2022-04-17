//
//  NewsFetcherProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 16.04.2022.
//

#import <Foundation/Foundation.h>
#import "NewsItemModel.h"

@protocol NewsFetcherProtocol <NSObject>

- (void)fetchNews:(void (^)(NSArray<NewsItemModel *> *, NSError *))completion
          fromURL: (NSURL *)url;

@end
