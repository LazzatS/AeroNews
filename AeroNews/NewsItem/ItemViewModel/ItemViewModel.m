//
//  ItemViewModel.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 01.05.2022.
//

#import "ItemViewModel.h"

@interface ItemViewModel ()

@property (nonatomic, strong) NSURL *url;

@end

@implementation ItemViewModel

+ (id<ItemViewModelProtocol>)newAllocInit:(ItemModel *)itemModel {
    
    ItemDisplayModel *displayModel = [[ItemDisplayModel alloc]
                                      initWithItemModel:itemModel];
    ItemViewModel *itemViewModel = [[ItemViewModel alloc] initWithItem:displayModel];
    
    return itemViewModel;
}

- (instancetype)initWithItem:(ItemDisplayModel *)displayModel {
    
    self = [super init];
    
    if (self) {
        self.url = [NSURL URLWithString:displayModel.itemURL];
    }
    
    return self;
}

- (void)loadWebView:(void (^)(NSURLRequest *))completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    completion(request);
}

@end
