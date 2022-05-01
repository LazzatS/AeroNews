//
//  ViewModelProtocol.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 15.04.2022.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"

@protocol ViewModelProtocol <NSObject>

#pragma mark - class method
+ (id<ViewModelProtocol>)newAllocInit;

#pragma mark - table view data source methods
- (void)getNewsFromURL: (NSURL *)url
               success: (void (^)(NSArray<ItemModel *> *))successCompletion
                 error: (void (^)(NSError *))errorCompletion;

#pragma mark - table view delegate methods
- (NSUInteger)numberOfNewsItems;
- (ItemModel *)newsItemAtIndexPath: (NSIndexPath *)indexPath;

@end
