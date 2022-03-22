//
//  NewsLoader.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsLoader : NSObject

- (void)loadNews:(void(^)(NSData*, NSError *))completion from: (NSURL *)url;

@end

NS_ASSUME_NONNULL_END
