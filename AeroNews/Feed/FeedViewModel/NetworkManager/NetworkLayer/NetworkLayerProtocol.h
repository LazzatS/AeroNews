//
//  NetworkLayerProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 16.04.2022.
//

#import "ItemModel.h"

@protocol NetworkLayerProtocol <NSObject>

- (void)fetchNewsFromURL:(NSURL *)url
             withSuccess:(void (^)(NSArray<ItemModel *> *))successCompletion
               withError:(void (^)(NSError *))errorCompletion;

@end
