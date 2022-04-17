//
//  NewsViewModelProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 15.04.2022.
//

#import <UIKit/UIKit.h>
#import "NewsItemModel.h"

@protocol NewsViewModelProtocol <NSObject>

- (void)getNewsWithSuccess: (void (^)(NSArray<NewsItemModel *> *))successCompletion
                     error: (void (^)(NSError *))errorCompletion
                   fromURL: (NSURL *)url;
- (NSUInteger)numberOfNewsItems;
- (NewsItemModel *)newsItemAtIndexPath: (NSIndexPath *)indexPath;

@end
