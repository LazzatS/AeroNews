//
//  NewsViewModel.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 13.03.2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NewsItemModel;
@class NewsLoader;
@class NewsXMLParser;

@interface NewsViewModel : NSObject {
    NewsLoader *newsLoader;
    NewsXMLParser *newsXMLParser;
}

#pragma mark - Private methods
- (NewsLoader *)newsLoader;
- (void)setNewsLoader:(NewsLoader *)newNewsLoader;
- (NewsXMLParser *)newsXMLParser;
- (void)setNewsXMLParser:(NewsXMLParser *)newNewsXMLParser;

#pragma mark - Public methods
- (void)fetchNews:(void (^)(NSArray<NewsItemModel *> *, NSError *))completion;
- (void)showAlert:(NSString *)title message: (NSString *)message on: (UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
