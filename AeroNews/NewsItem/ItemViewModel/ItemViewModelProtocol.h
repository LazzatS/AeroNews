//
//  ItemViewModelProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 01.05.2022.
//

#import <UIKit/UIKit.h>
#import "WebKit/WebKit.h"
#import "ItemDisplayModel.h"

@protocol ItemViewModelProtocol <NSObject>

#pragma mark - Class method
+ (id<ItemViewModelProtocol>)newAllocInit:(ItemModel *)itemModel;

#pragma mark - Custom initializer
- (instancetype)initWithItem: (ItemDisplayModel *)displayModel;

#pragma mark - Web view request methods
- (void)loadWebView:(void (^)(NSURLRequest *))completion;

#pragma mark - Details view methods
- (void)getNewsItemDetails: (void (^)(NSString *,
                                      NSString *,
                                      NSString *))completion;
- (NSURL *)getCurrentURL;

@end
