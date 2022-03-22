//
//  NewsParserProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <Foundation/Foundation.h>

@class NewsItemModel;

@protocol NewsParserProtocol <NSObject>

- (void)parseNews:(NSData *)data completion:(void(^)(NSArray<NewsItemModel *> *, NSError *))completion;

@end
