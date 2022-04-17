//
//  NewsLoaderProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 14.04.2022.
//

#import <Foundation/Foundation.h>

@protocol NewsLoaderProtocol <NSObject>

- (void)loadNews:(void(^)(NSData*, NSError *))completion
            from: (NSURL *)url;

@end
