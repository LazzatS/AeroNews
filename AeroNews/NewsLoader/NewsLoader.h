//
//  NewsLoader.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewsParserProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsLoader : NSObject

- (instancetype)initWithParser:(id<NewsParserProtocol>)parser;

- (void)loadNews:(void(^)(NSArray<NewsItemModel *> *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
