//
//  NewsLoaderProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 14.04.2022.
//

#import <Foundation/Foundation.h>

@protocol LoaderProtocol <NSObject>

- (void)loadNewsFromURL: (NSURL *)url
             completion: (void (^)(NSData *,
                                   NSError *))completion;

@end
