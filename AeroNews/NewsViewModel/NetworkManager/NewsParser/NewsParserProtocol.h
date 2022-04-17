//
//  NewsParserProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <Foundation/Foundation.h>
#import "NewsItemModel.h"

@protocol NewsParserProtocol <NSObject>

- (void)parseNews:(NSData *)data
       completion:(void(^)(NSArray<NewsItemModel *> *, NSError *))completion;

@end
