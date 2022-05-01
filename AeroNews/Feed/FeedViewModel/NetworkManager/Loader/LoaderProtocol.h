//
//  NewsLoaderProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 14.04.2022.
//

#import <Foundation/Foundation.h>

@protocol LoaderProtocol <NSObject>

#pragma mark - Custom initializer
- (instancetype)initWithURLString: (NSString *)urlString;

#pragma mark - Load method
- (void)loadNews:(void (^)(NSData *,
                           NSError *))completion;

@end
