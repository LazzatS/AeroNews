//
//  NetworkLayerProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 16.04.2022.
//

#import <Foundation/Foundation.h>
#import "ItemModel.h"

@protocol NetworkLayerProtocol <NSObject>

- (void)fetchNews:(void (^)(NSArray<ItemModel *> *, NSError *))completion
          fromURL: (NSURL *)url;

@end
