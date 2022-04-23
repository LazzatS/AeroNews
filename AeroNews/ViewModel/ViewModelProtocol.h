//
//  ViewModelProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 15.04.2022.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"

@protocol ViewModelProtocol <NSObject>

- (void)getNewsWithSuccess: (void (^)(NSArray<ItemModel *> *))successCompletion
                     error: (void (^)(NSError *))errorCompletion
                   fromURL: (NSURL *)url;
- (NSUInteger)numberOfNewsItems;
- (ItemModel *)newsItemAtIndexPath: (NSIndexPath *)indexPath;

@end
