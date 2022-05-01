//
//  ParserProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "ItemModel.h"

@protocol ParserProtocol <NSObject>

- (void)parseNews:(NSData *)data
       completion:(void (^)(NSArray<ItemModel *> *,
                            NSError *))completion;

@end
